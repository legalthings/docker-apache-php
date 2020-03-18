FROM php:7.3-apache
MAINTAINER Sven Stam <sven@legalthings.io>

RUN apt-get update && apt-get install -y \
        libssl-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
	libzip-dev \
        libicu-dev \
        g++ \
        libbase58-dev \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl gettext zip bcmath

RUN a2enmod rewrite
RUN pecl install mongodb && pecl install base58-0.1.3 && docker-php-ext-enable mongodb base58

RUN apt-get install -y libsodium-dev

RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ADD sample/ /app
ADD php.ini /usr/local/etc/php/php.ini

# Set dynamic memory limit
ENV phpmemory_limit=128M
RUN sed -i 's/memory_limit = .*/memory_limit = ${phpmemory_limit}/' /usr/local/etc/php/php.ini
