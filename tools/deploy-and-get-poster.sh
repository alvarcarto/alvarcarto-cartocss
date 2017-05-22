#!/bin/bash

set -e
set -x

COLOR="4b7b8f"
./tools/deploy.sh
sleep 5
curl -o "$COLOR.png" -H"x-api-key: secret" "http://207.154.251.20/render/api/raster/render?swLat=41.19935000018967&swLng=1.962713939614754&neLat=41.56365477513209&neLng=2.3705567107488723&style=transparent&posterStyle=polaroid&primaryColor=%23$COLOR&size=30x40cm&orientation=portrait&labelsEnabled=true&labelHeader=BARCELONA&labelSmallHeader=SPAIN%20/%20CATALONIA&labelText=41.382°N%20/%202.167°E"