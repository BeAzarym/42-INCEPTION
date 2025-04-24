#!/bin/bash
set -ex

if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

cd /var/www/wordpress || mkdir -p /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-load.php ]; then
    wp core download --path=/var/www/wordpress --allow-root
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create \
      --dbname="$SQL_DATABASE" \
      --dbuser="$SQL_USER" \
      --dbpass="$SQL_PASSWORD" \
      --dbhost="$SQL_HOSTNAME" \
      --path=/var/www/wordpress \
      --allow-root
fi

if ! wp core is-installed --path=/var/www/wordpress --allow-root; then
    wp core install \
      --url="$DOMAIN_NAME" \
      --title="$WP_TITLE" \
      --admin_user="$WP_ROOT_USER" \
      --admin_password="$WP_ROOT_PASSWORD" \
      --admin_email="$WP_ROOT_EMAIL" \
      --skip-email \
      --path=/var/www/wordpress \
      --allow-root

    if [ -n "$WP_USER" ] && [ -n "$WP_USER_EMAIL" ] && [ -n "$WP_USER_PASSWORD" ]; then
        wp user create "$WP_USER" "$WP_USER_EMAIL" \
          --user_pass="$WP_USER_PASSWORD" \
          --role=author \
          --path=/var/www/wordpress \
          --allow-root
    fi
fi

chown -R www-data:www-data /var/www/wordpress


exec php-fpm7.4 -F