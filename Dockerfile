# using nginx image as base
FROM nginx:latest

#copy the website
COPY my_website/ /usr/share/nginx/html