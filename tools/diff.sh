#!/bin/bash

set -e
set -x

node tools/diff.js acoustic-bw
node tools/diff.js bg-black
node tools/diff.js bg-darkgray
node tools/diff.js bg-gray
node tools/diff.js bg-sunset
node tools/diff.js black
node tools/diff.js bw
node tools/diff.js contrast-black-tampere contrast-black
node tools/diff.js countries
node tools/diff.js gray
node tools/diff.js petrol
