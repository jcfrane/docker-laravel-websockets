
FROM composer:latest as vendor

WORKDIR /var/www/html

COPY ./ ./
RUN composer install
RUN composer dump-autoload

FROM php:8.0-fpm as app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gettext-base \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng-dev \
        libssl-dev \
        libzip-dev \
        unzip \
        zip  \
    && apt-get clean \
    && pecl install redis \
    && docker-php-ext-configure gd \
        --with-jpeg=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-install \
        gd \
        exif \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        pcntl \
        zip \
    && docker-php-ext-enable gd \
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/*;

WORKDIR /var/www/html
COPY --from=vendor /var/www/html/ ./
COPY --from=vendor /usr/bin/composer /usr/bin/composer

COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD php artisan websockets:serve
