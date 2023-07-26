#!/bin/bash

# Web image name
WEB_IMAGE_NAME="my_website_image"

# Check if the docker-compose file exists
if [ ! -f "docker-compose.yml" ]; then
    echo "docker-compose.yml not found!"
    exit 1
fi

# Check if the image is available
if ! docker image inspect "$WEB_IMAGE_NAME" >/dev/null 2>&1; then
    echo "Container image not found"
    exit 1
fi

# Deploying the Infrastructure
echo "Deploying Docker Compose Infrastructure..."
docker compose up -d

echo "Docker Compose Infrastructure deployed!"