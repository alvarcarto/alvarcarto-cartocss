#!/bin/bash

set -e
set -x

mkdir -p dist
rm -f dist/*.xml
carto styles/black/project.mml > dist/black.xml
carto styles/bw/project.mml > dist/bw.xml
carto styles/copper/project.mml > dist/copper.xml
carto styles/cotton/project.mml > dist/cotton.xml
carto styles/gray/project.mml > dist/gray.xml
carto styles/pastel-blue/project.mml > dist/pastel-blue.xml
carto styles/pastel-green/project.mml > dist/pastel-green.xml
carto styles/petrol/project.mml > dist/petrol.xml
