
# Create a new role and two databases

echo " CREATE ROLE ifedayo WITH PASSWORD 'lovex' CREATEDB LOGIN;
CREATE DATABASE gp_practice_data; CREATE DATABASE protein;" | \
docker exec -i post_setup \ 
psql -U postgres

#stop the docker conatiner 
docker stop post_setup
