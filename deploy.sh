#!/bin/bash
rm -rf react || true
sudo docker system prune -y
#untaring
tar -xvzf react.tar.gz
cd react
#building
chmod +x build.sh
./build.sh
