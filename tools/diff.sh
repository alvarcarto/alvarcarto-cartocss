#!/bin/bash

set -e

OLD_MAP_STYLE=bw
NEW_MAP_STYLE=bw2

declare -a AREAS_Z17=(
  # Helsinki city center
  # http://localhost:3000/?debug=true&labelHeader=Espoo&labelSmallHeader=Finland&labelText=60.170%C2%B0N%20%2F%2024.940%C2%B0E&labelsEnabled=true&lat=60.1697&lng=24.9397&mapStyle=bw&orientation=portrait&posterStyle=sharp&size=50x70cm&updateCoords=true&zoom=16
  "swLat=60.16398457170071&swLng=24.931497573852543&neLat=60.175405485622655&neLng=24.947912693023685"

  # Bridge at Lauttasaari, Helsinki
  # http://localhost:3000/?debug=true&labelHeader=Espoo&labelSmallHeader=Finland&labelText=60.165%C2%B0N%20%2F%2024.897%C2%B0E&labelsEnabled=true&lat=60.1654&lng=24.8972&mapStyle=bw&orientation=portrait&posterStyle=sharp&size=50x70cm&updateCoords=true&zoom=16
  "swLat=60.159729441463604&swLng=24.88900082185865&neLat=60.17115183429847&neLng=24.905415941029794"

  # Large cross-road at motorway
  # http://localhost:3000/?debug=true&labelHeader=Espoo&labelSmallHeader=Finland&labelText=60.288%C2%B0N%20%2F%2024.981%C2%B0E&labelsEnabled=false&lat=60.2878&lng=24.9810&mapStyle=bw&orientation=portrait&posterStyle=sharp&size=50x70cm&updateCoords=true&zoom=16
  "swLat=60.282292801610126&swLng=24.972448954358697&neLat=60.2936725711471&neLng=24.988864073529847"

  # Small block at Nurmijärvi
  # http://localhost:3000/?debug=true&labelHeader=Nurmij%C3%A4rvi&labelSmallHeader=Finland&labelText=60.472%C2%B0N%20%2F%2024.812%C2%B0E&labelsEnabled=true&lat=60.4718&lng=24.8125&mapStyle=bw&orientation=portrait&posterStyle=sharp&size=50x70cm&updateCoords=true&zoom=16
  "swLat=60.46609854156724&swLng=24.80425533838571&neLat=60.47741429233369&neLng=24.820670457556847"
)

LEVEL="17"
index=0
for bounds in "${AREAS_Z17[@]}"
do
  oldname="z$LEVEL-$index-old.png"
  newname="z$LEVEL-$index-new.png"
  diffname="z$LEVEL-$index-diff.png"

  curl --fail -o images/diff/$oldname "https://tile-api.alvarcarto.com/render/api/raster/render-map?$bounds&mapStyle=$OLD_MAP_STYLE&width=1000&height=1500&apiKey=PERSONxMz4jp8tgACSKL7r"
  curl --fail -o images/diff/$newname "http://localhost:8001/api/raster/render-map?$bounds&mapStyle=$NEW_MAP_STYLE&width=1000&height=1500&apiKey=secret"
  convert images/diff/$oldname images/diff/$newname +append images/diff/$diffname
  # rm $oldname $newname

  index=$(expr $index + 1)
done
