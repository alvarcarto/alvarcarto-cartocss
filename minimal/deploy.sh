/Users/kbru/.nvm/versions/node/v6.7.0/bin/carto -a"3.0.0" project.mml > bw.xml
scp bw.xml alvar@alvar-map:~/alvarcarto-cartocss-bw/bw.xml
# ssh alvar@alvar-map "cd ~/osm/openstreetmap-carto && nik4.py -b 24.887995 60.188287 24.992709 60.133794 osm.xml --size-px 500 700 -v ~/image.png"
# scp alvar-map:~/image.png map.png && open map.png
