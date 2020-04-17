# Alvar Carto CartoCSS styles

![screenshot](docs/screenshot.png)

These are the CartoCSS map stylesheets for Alvar Carto. They are used to render maps, which you can see at https://design.alvarcarto.com.

Services which are using these styles:

* https://github.com/kimmobrunfeldt/alvarcarto-tile-service
* https://github.com/kimmobrunfeldt/alvarcarto-render-service

The scale of these styles is designed so that rendering to 256x256 pixels with
scale 1 provides correct result. When rendering the final posters, where canvas size
is thousands of pixels, we're applying a scale multiplier to mapnik rendering.

*Forked from: https://github.com/gravitystorm/openstreetmap-carto*

## Differences to original openstreetmap-carto project

* No labels or texts
* Roads, tunnels and bridges are shown already at zoom level 5 for artistic reasons
* Different postgis connection details
* Our customized country borders in project.mml (custom-alvar-countries)

### How build process works

The aim is that each style contains only the necessary declarations for that style. All common parts
are under [styles/base/](styles/base/) directory. The base styles can be configured via variables.

[tools/build.sh](tools/build.sh):

1. Convert template MMLs to full project files

    CartoCSS style's index file is project.mml. This file contains the SQL queries to get
    roads, buildings, etc. The project file is 99% same for all our styles, except the "Stylesheet"
    declaration. That's why our individual styles only define `project-sheet.mml` and it will
    be injected into `styles/base/project-template.mml`.

2. Convert `styles.js` declaration to actual CartoCSS to `generated-styles.mss` file.

    The `styles.js` uses our internal convenience format for generating styles for roads. It can
    be used for other generation as well.

    The main benefit of using this automation is to be able to generate consistent styles for each
    zoom level, using line color and thicnkess intepolation with given easing function. It removes
    the need to fine tune each zoom level color and thickness manually.

3. Compile the CartoCSS project with [https://github.com/mapbox/carto] to Mapnik XML stylesheet.



### Developing a new style

* First start the docker environment (postgres and render service)
* `cp -r styles/bw styles/new-style`
* Check that `project-sheet.mml` contains everything you need. Optionally add e.g. `../base/landcover.mss`.
* Edit `variables.mss` for land, water, and building colors
* Edit roads with `styles.js`. Other files already contain examples how to modify or extend the styles.
* Run `bash tools/build.sh new-style` to build the style
* Run `node tools/diff.js bw new-style` to render comparison images of different zoom levels

    The script will output images under `images/diff/` directory. It will fetch `new-style` from local
    docker environment and `bw` style from the current production environment for comparison.


## Usage

To compile CartoCSS projects to mapnik XML styles, run:

```bash
npm install
npm run build
```

Many warnings are generated by newer carto version, see: https://github.com/gravitystorm/openstreetmap-carto/issues/3183.

## Local development

First fetch data files for mapnik styles:

```bash
./tools/install.sh
```

Then run:

```bash
npm run watch
```

## Docker setup

To download data files

```bash
docker-compose run cartocss bash

# Note: for some reason get-shapefiles.py needs to be inside a directory, instead of being in the root
#       of the repo. Probably some bug in path joining code.
curl -o tools/get-shapefiles.py https://raw.githubusercontent.com/gravitystorm/openstreetmap-carto/master/scripts/get-shapefiles.py
python3 tools/get-shapefiles.py -f -d ../dist/data/
```

## CI setup

On each push to master, these mapnik styles are deployed to `alvar-map-qa` server.

## Debugging maps

To see exact names of data layers, use OpenStreeMap Editor: https://www.openstreetmap.org/edit. You need to login first.



