#!/bin/bash
ls 
#making react dirctory
mkdir react
#copying all file into directory
cp -f * react
#taring
tar -cvzf react.tar.gz react
#copying to deploy server
scp -o StrictHostKeyChecking=no -i $key react.tar.gz ubuntu@3.110.182.16:/home/ubuntu
ssh -T -o StrictHostKeyChecking=no -i $key ubuntu@3.110.182.16<<EOF
cd /home/ubuntu
rm -rf react || true
sudo docker system prune -y
#untaring
tar -xvzf react.tar.gz
cd react
#building
chmod +x build.sh
./build.sh
#dockerhub push
docker login --username=$docker_username --password=$docker_password
echo $docker_password | docker login -u $docker_username --password-stdin
docker tag react:v1 santoanandj/dev:v1
docker push santoanandj/dev:v1
