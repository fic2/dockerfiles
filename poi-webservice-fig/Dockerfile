FROM php:5.6-apache

# http://mediafi.org/?portfolio=poi-storage

RUN apt-get -y update && \
    apt-get -y install git

RUN pecl install mongo && \
    echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/

RUN rm -rf /var/www/html/* && \
    git clone https://github.com/stlemme/poi-webservice.git /var/www/html && \
    git submodule init && git submodule update && \
    mkdir api && ln -s /var/www/html /var/www/html/api/poi && \
    mv config.php.sample config.php

COPY config.php /var/www/html/


    