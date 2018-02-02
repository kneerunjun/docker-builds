FROM ubuntu:14.04
MAINTAINER kneerunjun

ARG SITENAME
ARG PORT

RUN apt-get update
RUN apt-get install -y nano htop nginx python3 git

RUN cat /etc/nginx/nginx.conf

COPY ./upstart.py /usr/local/bin/nginx.upstart.py
#here we can have a command that can let us pull the upstart file from git repo
#earlier we were maintaining the upstart file on the host / development machine, no we can pull it from github

#RUN cd /usr/local/src
#RUN git clone https://github.com/kneerunjun/docker-builds.git
#RUN cp ./docker-builds/base/nginx/upstart.py /usr/local/bin/nginx.upstart.py
RUN chmod a+x /usr/local/bin/nginx.upstart.py
RUN nginx.upstart.py $SITENAME $PORT

# lets just go aheadto print the conf file once
RUN cat /etc/nginx/nginx.conf
RUN service nginx stop
ENTRYPOINT ["nginx","-g","daemon off;"]
