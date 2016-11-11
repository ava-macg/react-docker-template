#!/bin/bash
# runs webpack in react container

NODE_ENV=${1:-local}
echo "Running with NODE_ENV=$NODE_ENV"

# stop and remove the containers if they are running
stop_and_remove_container()
{
    docker stop webpack
    docker rm webpack
}
stop_and_remove_container || true

# run the workbench container
docker run \
        -v $(pwd):/react \
        --name=webpack \
        -e NODE_ENV=$NODE_ENV \
        --entrypoint=/react/entrypoints/webpack.sh \
        -t 