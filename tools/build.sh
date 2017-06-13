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
