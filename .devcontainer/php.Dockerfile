FROM php:8.2-alpine AS base
RUN apk add --no-cache \
    git unzip libzip-dev sqlite-dev zlib-dev icu-dev g++ \
    && docker-php-ext-install intl zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
# Cachear dependencias de Composer
COPY apps/backend/codeigniter4/composer.* ./
RUN composer install --no-scripts --no-autoloader

COPY apps/backend/codeigniter4/ .
RUN composer dump-autoloader --optimize