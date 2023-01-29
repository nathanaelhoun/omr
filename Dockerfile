FROM php:8.2-cli-alpine

RUN apk add --upgrade --no-cache $PHPIZE_DEPS \
    linux-headers \
    git \
    imagemagick \
    imagemagick-dev

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install imagick \
    && docker-php-ext-enable imagick

RUN pecl install xdebug-3.2.0 \
    && docker-php-ext-enable xdebug

RUN echo "xdebug.mode=debug" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini > /dev/null && \
    echo "xdebug.start_with_request=trigger" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini > /dev/null && \
    echo "xdebug.client_host=host.docker.internal" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini > /dev/null && \
    echo "xdebug.discover_client_host=1" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini > /dev/null;
