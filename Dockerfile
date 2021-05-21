FROM python:3.7

RUN apt-get update && apt-get install -y apache2 && \
    apt-get install -y default-mysql-server && \
    apt-get install -y default-mysql-client && apt-get install -y php-mysql

RUN apt-get install nano

RUN apt-get install -y php

EXPOSE 80
EXPOSE 3306