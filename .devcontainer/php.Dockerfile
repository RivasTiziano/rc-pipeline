FROM php:8.2-cli

# Instalar dependencias de sistema (git, unzip, libzip para la extensión zip)
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libsqlite3-dev \
    zlib1g-dev \
    libicu-dev \
    g++ \
    && docker-php-ext-install intl zip \
    && docker-php-ext-enable intl zip

# Instalar Composer globalmente
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /workspaces/my-project/apps/backend