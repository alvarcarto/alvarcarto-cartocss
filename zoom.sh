#!/bin/bash

/Users/kbru/.nvm/versions/node/v6.7.0/bin/carto -a"3.0.0" project.mml > osm.xml
rm zoom.png
nik2img.py -c 24.940023 60.168081 -z 13 -d 2000 2800 -f png osm.xml zoom.png