#!/bin/bash

set -e
set -x

mkdir -p dist
rm -f dist/*.xml
carto styles/black/project.mml > dist/black.xml
carto styles/bw/project.mml > dist/bw.xml
carto styles/copper/project.mml > dist/copper.xml
carto styles/marshmellow/project.mml > dist/marshmellow.xml
carto styles/gray/project.mml > dist/gray.xml
carto styles/iceberg/project.mml > dist/iceberg.xml
carto styles/madang/project.mml > dist/madang.xml
carto styles/petrol/project.mml > dist/petrol.xml
carto styles/sunset/project.mml > dist/sunset.xml
carto styles/pure-white/project.mml > dist/pure-white.xml

carto styles/countries/project.mml > dist/countries.xml
carto styles/contrast-black/project.mml > dist/contrast-black.xml
carto styles/contrast-black-4x-roads/project.mml > dist/contrast-black-4x-roads.xml
carto styles/contrast-black-2x-roads/project.mml > dist/contrast-black-2x-roads.xml
carto styles/contrast-black-london/project.mml > dist/contrast-black-london.xml

node styles/js/generate.js styles/contrast-black-tampere/styles.js > styles/contrast-black-tampere/generated-styles.mss
carto styles/contrast-black-tampere/project.mml > dist/contrast-black-tampere.xml
carto styles/ideation/project.mml > dist/ideation.xml
carto styles/black-plywood/project.mml > dist/black-plywood.xml
carto styles/black-plywood-transparent/project.mml > dist/black-plywood-transparent.xml

node styles/js/generate.js styles/nightsky/roads.js > styles/nightsky/roads.mss
carto styles/nightsky/project.mml > dist/nightsky.xml

carto styles/bg-black/project.mml > dist/bg-black.xml
carto styles/bg-gray/project.mml > dist/bg-gray.xml
carto styles/bg-sunset/project.mml > dist/bg-sunset.xml
carto styles/bg-darkgray/project.mml > dist/bg-darkgray.xml

carto styles/acoustic-bw/project.mml > dist/acoustic-bw.xml
