FROM php:8.2-fpm-alpine

RUN mkdir -p /var/www/html

WORKDIR /var/www

RUN docker-php-ext-install pdo pdo_mysql

COPY --from=composer /usr/bin/composer /usr/bin/composer

