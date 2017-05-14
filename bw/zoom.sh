#!/bin/bash

/Users/kbru/.nvm/versions/node/v6.7.0/bin/carto -a"3.0.0" project.mml > osm.xml
rm map.png
nik2img.py -c 24.940023 60.188081 -z 10 -d 7583 9767 -f png osm.xml map.png
cp map.png ../alvarcarto-render-service/map.png