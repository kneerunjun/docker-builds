FROM ubuntu:14.04
MAINTAINER kneerunjun
RUN apt-get update
RUN apt-get install -y python3 python3-setuptools
RUN easy_install3 pip
RUN pip3 install django pymongo gunicorn django-cors-headers colormyprompt
