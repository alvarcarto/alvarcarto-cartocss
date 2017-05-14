#!/usr/bin/env node

var _ = require('lodash');
var fs = require('fs');
var path = require('path');
var child_process = require('child_process');
var carto = require('carto');
var mapnik = require('mapnik');
var mercator = require('./spherical');

var usage = 'usage: render.js <stylesheet> <image>';

var stylesheetPath = process.argv[2];
if (!stylesheetPath) {
  console.log(usage);
  process.exit(1);
}

var imagePath = process.argv[3];
if (!imagePath) {
  console.log(usage);
  process.exit(1);
}

mapnik.register_default_fonts();
mapnik.register_default_input_plugins();

function renderMapToFileSync(filePath, stylesheetPath, opts) {
  opts = _.merge({
    width: 5000,
    height: 7000,
    format: 'png',
    extent: [1185, 2331, 1186, 2332]
  }, opts);

  var bbox = mercator.xyz_to_envelope(60.168081, 24.940023, 10, false);
  var map = new mapnik.Map(opts.width, opts.height);
  var image = new mapnik.Image(map.width, map.height);
  map.extent = bbox;
  map.bufferedExtent = bbox;
  map.loadSync(stylesheetPath, {strict: true});

  map.render(image, {}, function(err, image) {
    if (err) throw err;

    console.log(image) // => mapnik image object with data from xml
    image.save('image.png', 'png', function(err) {
      if (err) throw err;
      // your custom code   
    });
  });
}

function main() {
  var isMmlFile = path.extname(stylesheetPath).match(/.mml/i);

  if (!isMmlFile) {
    renderMapToFileSync(imagePath, stylesheetPath);
    return;
  }

  var renderer = new carto.Renderer({
    filename: stylesheetPath,
    local_data_dir: path.dirname(stylesheetPath)
  });

  var stylesheet = JSON.parse(fs.readFileSync(stylesheetPath, 'utf-8'));
  renderer.render(stylesheet, function(err, output) {
    if (err) {
      if (Array.isArray(err)) {
        err.forEach(function(e) {
          carto.writeError(e, {});
        });
      }

      process.exit(1);
    }

    fs.writeFileSync(stylesheetPath.replace('mml', 'xml'), output, 'utf-8');
    stylesheetPath = stylesheetPath.replace('mml', 'xml');
    renderMap(stylesheetPath, imagePath);
  });
}

main();
