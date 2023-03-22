FROM php:7.2-alpine

ARG COMPOSER_VERSION=2

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --$COMPOSER_VERSION

RUN docker-php-ext-install mysqli pdo pdo_mysql

# Add what is required for gd extension based on this Stackoverflow question:
# https://stackoverflow.com/questions/39657058/installing-gd-in-docker
RUN apk add --no-cache \
      freetype \
      libjpeg-turbo \
      libpng \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
    && docker-php-ext-configure gd \
      --with-gd \
      --with-jpeg-dir \
      --with-png-dir \
      --with-zlib-dir \
      --with-freetype-dir \
    && docker-php-ext-install gd \
    && apk del --no-cache \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
    && rm -rf /tmp/*
