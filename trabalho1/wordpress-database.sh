#!/bin/bash

function ensure_db() {
docker run -d \
  --name wordpress-db \
  -e MYSQL_ROOT_PASSWORD=wordpress \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wordpress \
  -e MYSQL_PASSWORD=wordpress \
  -p 3306:3306 \
  mysql:latest
}

function ensure_app() {
docker run -d \
  --name wordpress-container \
  --link wordpress-db \
  -e WORDPRESS_DB_HOST=wordpress-db:3306 \
  -e WORDPRESS_DB_NAME=wordpress \
  -e WORDPRESS_DB_USER=wordpress \
  -e WORDPRESS_DB_PASSWORD=wordpress \
  -p 8080:80 \
  wordpress:latest
}

ensure_db
#wait db wake up
sleep 30
ensure_app