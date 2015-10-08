FROM debian:jessie

RUN apt-get -y update \
    && apt-get -y install curl \
    && curl -s http://repository.mivoq.it/mivoq.gpg.key | apt-key add - \
    && echo "deb http://repository.mivoq.it/repositories/apt/debian experimental main" > /etc/apt/sources.list.d/fatts.list \
    && apt-get -y update \
    && apt-get -y install `apt-cache search '^marytts-voice-' | sed -e 's/ .*//'` \
    && apt-get -y clean

EXPOSE 59125

CMD ["/usr/bin/marytts-server","--","-Dlog4j.logger.marytts=INFO,stderr"]

