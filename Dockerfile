FROM nginx:stable-alpine
COPY site/index.html /usr/share/nginx/html/index.html
EXPOSE 80
