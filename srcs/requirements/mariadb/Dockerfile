FROM debian:bullseye

# UPDATE AND INSTALLING NGINX AND OPENSSL (CERTIF). CLEANING AFTER ALL FOR LAYER OPTIMISATION
RUN apt update -y && apt install -y  mariadb-server && rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/init-db.sh /

RUN chmod +x /init-db.sh

ENTRYPOINT ["/init-db.sh"]