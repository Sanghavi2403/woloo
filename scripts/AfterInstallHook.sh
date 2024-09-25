#!/bin/bash
set -e
cd /home/ubuntu/woloo
npm install
npm run build
# Kill Pm2 Process
pm2 kill
