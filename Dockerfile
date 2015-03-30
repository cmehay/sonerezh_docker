FROM    debian:wheezy

CMD     ["/usr/bin/supervisord", "-n"]

EXPOSE  80

ENV     DEBIAN_FRONTEND noninteractive

# Music links directory
ENV     MUSIC_LINKS /music_links

ADD     etc /etc
ADD     update_links /update_links

RUN     apt-get -y update && \
        apt-get -y dist-upgrade && \
        apt-get -y install nginx php5-fpm php5-gd php5-mysql libav-tools supervisor git inotify-tools ca-certificates

RUN     rm /etc/nginx/sites-enabled/default

RUN     mkdir /music
RUN     mkdir ${MUSIC_LINKS}

VOLUME  /music
RUN     chown www-data:www-data /music
RUN     chown www-data:www-data /${MUSIC_LINKS}

RUN     mkdir -p /var/www/sonerezh
RUN     chown www-data:www-data /var/www/sonerezh
USER    www-data
RUN     git clone --branch 1.0.0 https://github.com/Sonerezh/sonerezh.git /var/www/sonerezh

# Replace music directory placeholder with the good one
RUN     sed -i "s|/home/jdoe/Music|${MUSIC_LINKS}|g" /var/www/sonerezh/app/View/Installers/index.ctp

USER    root
