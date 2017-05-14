#!/bin/bash

/Users/kbru/.nvm/versions/node/v6.7.0/bin/carto -a"3.0.0" project.mml > osm.xml
rm zoomed.png helsinki.png
nik2img.py -b 24.9349 60.1554 24.9510 60.1492 osm.xml -d 2000 2800 -v -f png zoomed.png
nik2img.py -b 24.887995 60.188287 24.992709 60.133794 osm.xml -d 2000 2800 -v -f png helsinki.png