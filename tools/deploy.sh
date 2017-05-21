#!/bin/bash

set -e
set -x

npm run build
scp -r dist/*.xml alvar@$SERVER_HOST:~/mapnik-styles
ssh alvar@$SERVER_HOST "bash -l -c \"PATH=$PATH:/home/alvar/.nvm/versions/node/v6.9.4/bin pm2 restart all\""