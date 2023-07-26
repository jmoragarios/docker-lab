#!/bin/bash

# Web container image name
WEB_IMAGE_NAME="my_website_image"
# Web container name
WEB_CONTAINER_NAME="my_web_container"

# MySQL container image name
DB_IMAGE_NAME="mysql:latest"
# MySQL container name
DB_CONTAINER_NAME="my_db_container"
# MySQL "root" user password
MYSQL_ROOT_PASSWORD="pass"

# Build the web container
build_web_image() {
    echo "building the web container..."
    docker build -t "$WEB_IMAGE_NAME" .
}

# Running the web container and matching the ports
run_web_container() {
    echo "Running web container and matching ports..."
    docker run -d -p 8080:80 --name "$WEB_CONTAINER_NAME" "$WEB_IMAGE_NAME"
}

# Building database container and linking it with the web conainer
run_mysql_container() {
    echo "Running the db container and linking it with the web container..."
    docker run -d --name "$DB_CONTAINER_NAME" -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" "$DB_IMAGE_NAME"
    docker network connect "$WEB_CONTAINER_NAME" "$DB_CONTAINER_NAME"
}

# Validate connection betwwen containers
validate_connection() {
    echo "Validating connection between containers..."
    docker exec -it "$WEB_CONTAINER_NAME" ping -c 4 "$DB_CONTAINER_NAME"
}

# Some help messages
show_help() {
    echo "Usage: $0 [option]"
    echo "Available Options:"
    echo "    build      Build web container"
    echo "    run          Run web container and link with MySQL"
    echo "    validate    Validate connection between containers"
    echo "    help        Show this help message"
}

# Validating arguments
if [ "$1" == "build" ]; then
  build_web_image
elif [ "$1" == "run" ]; then
  run_web_container
  run_mysql_container
elif [ "$1" == "validate" ]; then
  validate_connection
else
  show_help
fi