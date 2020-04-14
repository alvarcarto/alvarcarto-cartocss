const path = require('path');
const BPromise = require('bluebird');
const fs = BPromise.promisifyAll(require('fs'));
const _ = require('lodash');
const SphericalMercator = require('@mapbox/sphericalmercator');
const BlinkDiff = require('blink-diff');
const sharp = require('sharp');
const request = require('request-promise');
const prettyBytes = require('pretty-bytes');

const OLD_MAP_STYLE = 'bw'
const NEW_MAP_STYLE = 'bw2'
const WRITE_DIFF = true;

const locations = [
  // Helsinki city center
  // http://localhost:3000/?debug=true&lat=60.1697&lng=24.9397&mapStyle=bw&orientation=portrait&labelsEnabled=false&size=50x70cm&updateCoords=true&zoom=16
  { lat: 60.1697, lng: 24.9397 },

  // Bridge at Lauttasaari, Helsinki
  // http://localhost:3000/?debug=true&lat=60.1654&lng=24.8972&mapStyle=bw&orientation=portrait&labelsEnabled=false&size=50x70cm&updateCoords=true&zoom=16
  { lat: 60.1654, lng: 24.8972 },

  // Large cross-road at motorway
  // http://localhost:3000/?debug=true&lat=60.2878&lng=24.9810&mapStyle=bw&orientation=portrait&abelsEnabled=ffalse&size=50x70cm&updateCoords=true&zoom=16
  { lat: 60.2878, lng: 24.9810 },

  // Small block at Nurmijärvi
  // http://localhost:3000/?debug=true&labelHeader=Nurmij%C3%A4rvi&labelSmallHeader=Finland&labelText=60.472%C2%B0N%20%2F%2024.812%C2%B0E&labelsEnabled=true&lat=60.4718&lng=24.8125&mapStyle=bw&orientation=portrait&posterStyle=sharp&size=50x70cm&updateCoords=true&zoom=16
  { lat: 60.4718, lng: 24.8125 },
]

const merc = new SphericalMercator({
  size: 256,
});

function getLatLngBounds(latLngCenter, zoom, viewportWidthPx, viewportHeightPx) {
  const pxCenter = merc.px([latLngCenter.lng, latLngCenter.lat], zoom);
  const pxBottomLeft = [pxCenter[0] - viewportWidthPx / 2, pxCenter[1] + viewportHeightPx / 2];
  const pxTopRight = [pxCenter[0] + viewportWidthPx / 2, pxCenter[1] - viewportHeightPx / 2];
  const swLatLng = merc.ll(pxBottomLeft, zoom);
  const neLatLng = merc.ll(pxTopRight, zoom);
  return [{ lat: swLatLng[1], lng: swLatLng[0] }, { lat: neLatLng[1], lng: neLatLng[0] }];
}

async function downloadImage(baseUrl, location, opts) {
  // Based on 50x70cm poster in designer at retina mode
  const width = 765 * 2;
  const height = 1070 * 2;

  const bounds = getLatLngBounds(
    { lat: location.lat, lng: location.lng },
    opts.zoom,
    width,
    height,
  );

  const reqOpts = {
    encoding: null,
    resolveWithFullResponse: true,
    timeout: 30 * 60 * 1000,
    url: `${baseUrl}/api/raster/render-map`,
    qs: {
      swLat: bounds[0].lat,
      swLng: bounds[0].lng,
      neLat: bounds[1].lat,
      neLng: bounds[1].lng,
      mapStyle: opts.mapStyle,
      width,
      height,
      apiKey: opts.apiKey,
    },
  };

  const params = new URLSearchParams(reqOpts.qs);
  console.log(`${reqOpts.url}?${params.toString()}`);

  const res = await request(reqOpts);
  console.info(`Downloaded ${prettyBytes(res.body.byteLength)} data`);

  return res.body;
}

function getPath(relative) {
  return path.join(__dirname, '../', relative);
}

async function resizeToHeight(imgBuffer, height) {
  const resized = await sharp(imgBuffer)
    .limitInputPixels(false)
    .resize(null, height)
    .png()
  return resized;
}

async function main() {
  const zoomLevels = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
  // const zoomLevels = _.reverse(_.range(1, 18));

  await BPromise.each(zoomLevels, async (zoomLevel) => {
    await BPromise.each(locations, async (location, locIndex) => {
      if (zoomLevel < 15 && locIndex > 0) {
        console.log(`Zoom level is low, ignoring location at index ${locIndex} ..`);
        return;
      }

      console.log(`Zoom level ${zoomLevel}, location at index ${locIndex} ..`);

      const newImageName = `images/diff/z${zoomLevel}-${locIndex}-new.png`;
      const newImage = await downloadImage('http://localhost:8001', location, {
        zoom: zoomLevel,
        apiKey: 'secret',
        mapStyle: NEW_MAP_STYLE,
      });
      await fs.writeFileAsync(getPath(newImageName), newImage, { encoding: null });

      const oldImageName = `images/diff/z${zoomLevel}-${locIndex}-old.png`;
      const oldExists = fs.existsSync(getPath(oldImageName));
      if (!oldExists) {
        const oldImage = await downloadImage('http://54.36.173.210:8001', location, {
          zoom: zoomLevel,
          // Gains access to our internal render api, it is ok-level risk for private repos.
          apiKey: 'PERSONxMz4jp8tgACSKL7r',
          mapStyle: OLD_MAP_STYLE,
        });
        await fs.writeFileAsync(getPath(oldImageName), oldImage, { encoding: null });
      } else {
        console.log(`${oldImageName} exists, skipping download..`);
      }

      if (WRITE_DIFF) {
        const diffImageName = `images/diff/z${zoomLevel}-${locIndex}-diff.png`;
        const diff = new BlinkDiff({
          imageAPath: getPath(oldImageName),
          imageBPath: getPath(newImageName),
          thresholdType: BlinkDiff.THRESHOLD_PERCENT,
          threshold: 0.01,
          imageOutputPath: getPath(diffImageName),
        });
        const promisifiedDiff = BPromise.promisifyAll(diff);
        const diffResult = await promisifiedDiff.runAsync();
        if (diffResult.differences > 1) {
          console.error(`Found ${diffResult.differences} differences`);
        }
      }
    });
  });
}

main()
  .then(() => console.log('Done.'))
  .catch(err => {
    throw err
  });