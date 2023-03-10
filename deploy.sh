#!/bin/bash
ls -l
mkdir react 
mv -f * react
tar -cvzf react.tar.gz react
scp -o StrictHostKeyChecking=no -i $key react.tar.gz ubuntu@3.110.182.16:/home/ubuntu
ssh -T -o StrictHostKeyChecking=no -i $key ubuntu@3.110.182.16<<EOF
cd /home/ubuntu
rm -rf react || true
sudo docker system prune
tar -xvzf react.tar.gz
#deploy on which git branch commit had happen
if [[ $GIT_BRANCH == origin/dev ]]
then
        cd react
	chmod +x build.sh
        ./build.sh
        docker login --username=$docker_username --password=$docker_password
        echo $docker_password | docker login -u $docker_username --password-stdin
	docker image tag react:v1 santoanandj/dev:v1
        docker image push santoanandj/dev:v1
elif [[ $GIT_BRANCH == origin/main ]]
then
        cd react
	chmod +x build.sh
        ./build.sh
	docker login --username=$docker_username --password=$docker_password
        echo $docker_password | docker login -u $docker_username --password-stdin	
        docker image tag react:v1 santoanandj/prod:v1
        docker image push santoanandj/prod:v1
else
        echo "deployment is failure"
fi
