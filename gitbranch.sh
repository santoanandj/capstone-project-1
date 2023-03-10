#!/bin/bash
if [[ $GIT_BRANCH == origin/dev ]]
then
        chmod +x build.sh
        build.sh
        docker tag react:v1 santoanandj/dev:v1
        docker push santoanandj/dev:v1
        #dockerhub push
        docker login --username=$docker_username --password=$docker_password
        echo $docker_password | docker login -u $docker_username --password-stdin
elif [[ $GIT_BRANCH == origin/main ]]
then
        chmod +x build.sh
        ./build.sh
 	docker tag react:v1 santoanandj/prod:v1
        docker push santoanandj/prod:v1
        #dockerhub push
        docker login --username=$docker_username --password=$docker_password
        echo $docker_password | docker login -u $docker_username --password-stdin
else
        echo "deployment is failure"
fi

