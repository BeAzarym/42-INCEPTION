FROM debian:bullseye

RUN apt update -y && apt install -y php7.4-fpm php7.4-mysql curl mariadb-client tar  && rm -rf /var/lib/apt/lists/* && mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/init-wp.sh /

RUN chmod +x /init-wp.sh

ENTRYPOINT ["/init-wp.sh"]