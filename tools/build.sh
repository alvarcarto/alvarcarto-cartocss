#!/bin/bash

# Usage: bash tools/build.sh [style]
# Run from repository root!

set -e
set -x

mkdir -p dist
rm -f dist/*.xml
find ./styles -name 'generated-project.mml' -delete
find ./styles -name 'generated-styles.mss' -delete

dir_suffix=""
if [[ -n "$1" ]]; then
  dir_suffix="/$1"
fi

# Convert templates to full project files
for i in $(find ./styles$dir_suffix -name 'project-sheet.mml');
do
  dir=$(dirname "$i")
  node js/convert-to-project.js "$i" > "$dir/generated-project.mml"

done

# Generate styles with JS
for i in $(find ./styles$dir_suffix -name 'styles.js');
do
  dir=$(dirname "$i")
  node js/generate.js "$i" > "$dir/generated-styles.mss"

done

# Generate styles with JS
for i in $(find ./styles$dir_suffix -name 'generated-project.mml');
do
  dir=$(dirname "$i")
  style=$(basename "$dir")
  # Make warnings quiet, see: https://github.com/gravitystorm/openstreetmap-carto/issues/3183.
  # Use certain mapnik API version
  carto --api 3.0.23 --quiet "$i" > "dist/$style.xml"
done
