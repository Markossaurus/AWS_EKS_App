FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY . .
VOLUME ["/nginx"]
CMD ["nginx", "-g", "daemon off;"]