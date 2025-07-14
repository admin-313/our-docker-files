#!/bin/sh

curl -o docker-compose.yml https://raw.githubusercontent.com/admin-313/our-docker-files/refs/heads/main/compose-files/minio/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/admin-313/our-docker-files/refs/heads/installation-script-minio/compose-files/minio/example.env

echo "######################################"
echo "CONSIDER CHANGING .env file's default values with vim .env"
echo "######################################"
