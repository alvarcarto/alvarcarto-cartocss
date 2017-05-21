#!/bin/bash

set -e
set -x

mkdir -p dist
carto styles/bw/project.mml > dist/bw.xml
carto styles/minimal/project.mml > dist/minimal.xml
