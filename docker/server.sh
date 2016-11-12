#!/bin/bash
# runs webpack in react container

NODE_ENV=${1:-local}
echo "Running with NODE_ENV=$NODE_ENV"

#set container name based on parent repo
set_tag()
{   
    readlink -e $0
    cd $(dirname $(readlink -e $0))
    tag=$(dirname $PWD)
    tag=${tag##*/}
    cd ..
}

#build container if it doesn't already exist
build_container()
{   
    if [[ $(docker images -q $tag 2> /dev/null) == "" ]]; then
        echo "image not found; building container"
        docker build -t $tag .
    fi
}
set_tag && build_container


# stop and remove the containers if they are running
stop_and_remove_container()
{
    docker stop react-server
    docker rm react-server
}

stop_and_remove_container || true

# run the workbench container
docker run \
    -v $(pwd):/react \
    --name=react-server \
    -e NODE_ENV=$NODE_ENV \
    --publish 3000:3000 \
    --entrypoint=/react/entrypoints/server.sh \
    -t $tag
