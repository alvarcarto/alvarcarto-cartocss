#!/bin/bash

set -e
set -x

mkdir -p dist/data
cd dist
python ../tools/get-shapefiles.py -f

