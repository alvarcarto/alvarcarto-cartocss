#!/bin/bash

set -e
set -x

mkdir -p dist
rm dist/*.xml
carto styles/bw/project.mml > dist/bw.xml
carto styles/transparent/project.mml > dist/transparent.xml
carto styles/black/project.mml > dist/black.xml
carto styles/bw-dark/project.mml > dist/bw-dark.xml
