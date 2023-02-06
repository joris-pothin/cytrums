FROM php:8.2-fpm
MAINTAINER Baptiste Donaux <baptiste.donaux@gmail.com>

ARG PHP_APCU_VERSION=5.1.20
ARG PHP_XDEBUG_VERSION=3.0.3

RUN apt-get update \
    && apt-get install -y \
        libzip-dev \
        libicu-dev \
        zlib1g-dev \
        git less unzip wget stow \
    && docker-php-source extract \
    && curl -L -o /tmp/apcu-$PHP_APCU_VERSION.tgz https://pecl.php.net/get/apcu-$PHP_APCU_VERSION.tgz \
    && curl -L -o /tmp/xdebug-$PHP_XDEBUG_VERSION.tgz http://xdebug.org/files/xdebug-$PHP_XDEBUG_VERSION.tgz \
    && tar xfz /tmp/apcu-$PHP_APCU_VERSION.tgz \
    && tar xfz /tmp/xdebug-$PHP_XDEBUG_VERSION.tgz \
    && rm -r \
        /tmp/apcu-$PHP_APCU_VERSION.tgz \
        /tmp/xdebug-$PHP_XDEBUG_VERSION.tgz \
    && mv apcu-$PHP_APCU_VERSION /usr/src/php/ext/apcu \
    && mv xdebug-$PHP_XDEBUG_VERSION /usr/src/php/ext/xdebug \
    && docker-php-ext-install \
        apcu \
        intl \
        mbstring \
        mysqli \
        xdebug \
        zip \
    && docker-php-source delete \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer
