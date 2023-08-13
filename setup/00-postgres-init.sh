#!/bin/bash


# create directory if does not exist
if [ -d "$HOME/docker/volumes/postgres" ]

then
    echo "Directory $HOME/docker/volumes/postgres exist."
else
    echo "Error: Directory $HOME/docker/volumes/postgres does not exists."
    mkdir -p $HOME/docker/volumes/postgres

fi


# Launch the postgress image called  'post_setup',
# attach it to the local volume 

docker run --rm --name post_setup \
   -e POSTGRES_USER=postgres \
   -e POSTGRES_PASSWORD=docker \
   -d \
   -p 5432:5432 \
   -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data \
   postgres:13.3

# wait for the postgress service to be ready 

echo "CREATE DATABASE single_cell; CREATE DATABASE protein;" | \
docker exec -i post_setup \
psql -U postgres

docker stop post_setup
