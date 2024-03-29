FROM php:7.3.4-apache

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y zlib1g-dev libzip-dev

RUN docker-php-ext-install pdo pdo_mysql zip

# For development environment
RUN usermod --non-unique --uid 1000 www-data && groupmod --non-unique --gid 1000 www-data

# Installs Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

ENV PATH="/root/.composer/vendor/bin:${PATH}"

RUN php -r "mkdir('/opt/app', 0755);"

WORKDIR /opt/app

RUN rm -rf /var/www/html

RUN ln -s /opt/app/public /var/www/html
