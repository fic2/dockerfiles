FROM php:5.6-apache

# http://mediafi.org/?portfolio=poi-storage

RUN apt-get -y update && \
    apt-get -y install wget unzip git && \
    wget https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego -P /usr/local/bin && \
    chmod +x /usr/local/bin/forego

RUN pecl install mongo && \
    echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini && \
    mkdir -p /data/db && \
    wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.6.6.tgz -P /tmp/ && \
    tar -xvf /tmp/mongodb-linux-x86_64-2.6.6.tgz --strip-components 2 -C /usr/local/bin/ mongodb-linux-x86_64-2.6.6/bin && \
    rm /tmp/mongodb-linux-x86_64-2.6.6.tgz

RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/ && \
    ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/

RUN rm -rf /var/www/html/* && \
    git clone https://github.com/stlemme/poi-webservice.git /var/www/html && \
    git submodule init && git submodule update && \
    mkdir api && ln -s /var/www/html /var/www/html/api/poi && \
    mv config.php.sample config.php

COPY Procfile config.php /var/www/html/

CMD ["/usr/local/bin/forego", "start", "-f", "/var/www/html/Procfile"]


    