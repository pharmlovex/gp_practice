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

if ! command -v timeout &> /dev/null
then
    echo "`timeout` could not be found.
    exit
fi

timeout 20s bash -c "until docker exec post_setup pg_isready; do sleep 1; done"

# Create a new role and two databases

echo " CREATE ROLE ifedayo WITH PASSWORD 'lovex' CREATEDB LOGIN;
CREATE DATABASE gp_practice_data; CREATE DATABASE protein;" | \
docker exec -i post_setup \ 
psql -U postgres

#stop the docker conatiner 
docker stop post_setup
