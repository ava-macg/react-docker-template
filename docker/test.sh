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
}

#build container if it doesn't already exist
build_container()
{   
    if [[ $(docker images -q $tag 2> /dev/null) == "" ]]; then
        echo "image not found; building container"
        cd ..
        docker build -t $tag .
    fi
}
set_tag && build_container


# run the workbench container
docker run \
    -v $(pwd):/react \
    --rm \
    -e NODE_ENV=$NODE_ENV \
    --entrypoint=/react/entrypoints/test.sh \
    -t $tag
