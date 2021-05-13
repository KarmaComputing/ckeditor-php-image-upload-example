FROM php:7.4-apache

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        libpng-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd

RUN mkdir /var/www/html/uploads/

COPY index.html /var/www/html
COPY ckeditor5-build-classic /var/www/html/ckeditor5-build-classic
COPY ckfinder /var/www/html/ckfinder

RUN mkdir -p /var/www/html/uploads/.ckfinder/cache/thumbs1
RUN chown -R www-data:www-data /var/www/html

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
