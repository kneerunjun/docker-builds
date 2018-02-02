FROM ubuntu:14.04
MAINTAINER kneerunjun

ARG SITENAME
ARG PORT

RUN apt-get update
RUN apt-get install -y nano htop nginx python3 git

#here we try to change the nginx configuration
RUN useradd nginx 
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx_old.conf
RUN echo "user nginx;worker_processes 4;pid /run/nginx.pid;\nevents {worker_connections 1024;}\nhttp {sendfile on;tcp_nopush on;tcp_nodelay on;keepalive_timeout 65;types_hash_max_size 2048;include /etc/nginx/mime.types;default_type application/octet-stream;access_log /var/log/nginx/access.log;error_log /var/log/nginx/error.log;gzip on;gzip_disable "msie6";include /etc/nginx/conf.d/*.conf;include /etc/nginx/sites-enabled/*;}" > /etc/nginx/nginx.conf
RUN touch /etc/nginx/sites-available/$SITENAME
RUN echo "server {listen $PORT ;root /var/www/$SITENAME;server_name localhost;index index.html;location / {autoindex on;}location /libs {alias   /var/www/libs;autoindex   on;}}" > /etc/nginx/sites-available/$SITENAME
RUN ln -s /etc/nginx/sites-available/$SITENAME /etc/nginx/sites-enabled/$SITENAME
RUN cat /etc/nginx/nginx.conf
RUN service nginx stop
ENTRYPOINT ["nginx","-g","daemon off;"]
