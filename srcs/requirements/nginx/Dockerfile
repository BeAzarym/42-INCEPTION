FROM debian:bullseye

# UPDATE AND INSTALLING NGINX AND OPENSSL (CERTIF). CLEANING AFTER ALL FOR LAYER OPTIMISATION
RUN apt update -y && apt install -y nginx openssl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/nginx /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/sites-available/default

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/cchabeau.key -out /etc/nginx/ssl/cchabeau.crt -subj "/CN=cchabeau"

CMD ["nginx", "-g", "daemon off;"]