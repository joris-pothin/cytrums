#################################
FROM composer:2.0.2 as composer
#################################
ARG APP_ENV

RUN rm -rf /var/www && mkdir /var/www
WORKDIR /var/www
COPY composer.* /var/www/

RUN set -xe \
    && if [ "$APP_ENV" = "prod" ]; then export ARGS="--no-dev --optimize-autoloader"; fi \
    && composer install --ignore-platform-reqs --prefer-dist --no-scripts --no-progress --no-suggest --no-interaction $ARGS

# Copy entier app for next stage
COPY . /var/www

RUN composer dump-autoload --optimize --classmap-authoritative

################################
FROM php:8.2-cli-alpine as base
################################
ARG APP_ENV
ARG TZ='Europe/Paris'

ENV DEFAULT_TZ ${TZ}

WORKDIR /var/www

# Iconv workaround
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# Install dependencies
RUN set -xe \
    && apk add --no-cache \
        $PHPIZE_DEPS \
        bash \
        tzdata \
        icu-dev \
        freetype libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        rabbitmq-c rabbitmq-c-dev \
        supervisor \
        libzip-dev \
        zip \
        # Imagick
        imagemagick \
        imagemagick-libs \
        imagemagick-dev \
        php7-imagick \
        # wkHtmlToPdf dependencies \
        libgcc \
        libstdc++ \
        libx11 \
        glib \
        libxrender \
        libxext \
        libintl \
        ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-freefont \
    && pecl install amqp apcu opcache redis imagick \
    && apk add --no-cache bash icu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure zip \
    && docker-php-ext-enable amqp apcu opcache redis imagick \
    && docker-php-ext-install gd pdo pdo_mysql intl pcntl zip \
    && cp /usr/share/zoneinfo/${DEFAULT_TZ} /etc/localtime \
    && apk del tzdata \
    && rm -rf \
      /var/cache/apk/*

COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-606718795 /bin/wkhtmltopdf /usr/bin/wkhtmltopdf
COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-606718795 /bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf

#
#################################
FROM base
#################################
ARG APP_ENV
ARG APP_DEBUG

ENV APP_ENV $APP_ENV
ENV APP_DEBUG $APP_DEBUG

# Customize php
COPY docker/php-cli/ini/${APP_ENV}.ini "${PHP_INI_DIR}/conf.d/cytrums.ini"

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer self-update

COPY --from=composer /var/www/ /var/www/
