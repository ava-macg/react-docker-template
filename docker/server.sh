#!/bin/bash
# runs webpack in react container

NODE_ENV=${1:-local}
echo "Running with NODE_ENV=$NODE_ENV"

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
    -t 
