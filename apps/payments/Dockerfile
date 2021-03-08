# Generate SSL/TLS cert and key.
FROM debian:buster-slim AS cert_builder
RUN apt update && apt install -y openssl
RUN sed -i 's/^# subjectAltName=email:copy/subjectAltName=DNS:localhost/g' /etc/ssl/openssl.cnf
RUN /usr/bin/openssl req \
-subj '/CN=localhost/O=Wikimedia/C=UK' \
-nodes \
-new \
-x509 \
-newkey rsa:2048 \
-keyout /etc/ssl/certs/payments.key \
-out /etc/ssl/certs/payments.crt \
-days 1095

# Build Payments-wiki environment
FROM php:7.4-apache-buster
RUN apt-get update && apt-get install -y mariadb-client \
curl \
git \
unzip \
sudo \
rsyslog \
libmagickwand-dev \
libjpeg-dev \
libpng-dev \
libgmp-dev \
libsodium-dev \
zlib1g-dev \
libzip-dev \
libc-client-dev \
libicu-dev \
libjpeg62-turbo-dev \
libkrb5-dev \
libmagickwand-dev \
libpng-dev \
libxml2-dev \
nano \
less

RUN docker-php-ext-install mysqli \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && docker-php-ext-install gd \
    && docker-php-ext-install gmp \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath

RUN pecl install imagick \
    && pecl install redis-5.1.1 \
    && pecl install apcu-5.1.19 \
    && pecl install xdebug \
    && pecl install ast \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable apcu \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable ast

ARG user_id
ARG group_id
RUN addgroup --gid=$group_id docker
RUN useradd --home-dir /docker --create-home --uid $user_id --gid $group_id docker

#let's use a tag instead
COPY ./src /var/www/html/
COPY ./docker /docker/
RUN chown -R docker /docker

COPY ./docker/rsyslog.conf /etc/rsyslog.conf
COPY ./docker/php.ini /usr/local/etc/php/php.ini
COPY ./docker/xdebug.ini /usr/local/etc/php/conf.d/_xdebug.ini
RUN touch /var/log/xdebug.log
RUN chown -R docker /var/log/

COPY ./docker/config/smashpig/public/ /etc/smashpig/
COPY ./docker/config/smashpig/private/ /etc/smashpig/

COPY --from=cert_builder /etc/ssl/certs/ /etc/ssl/certs/
COPY ./docker/payments.ssl.conf /etc/apache2/sites-available/
RUN a2enmod ssl
RUN service apache2 restart
RUN a2dissite 000-default.conf
RUN a2ensite payments.ssl.conf

WORKDIR /tmp
RUN curl --silent --fail --output composer.phar https://getcomposer.org/download/1.10.5/composer.phar \
    && sha256sum -c /docker/composer.phar.sha256sum \
    && chmod +x /tmp/composer.phar \
    && mv /tmp/composer.phar /usr/bin/composer

WORKDIR /var/www/html
EXPOSE 8000

ENTRYPOINT /usr/sbin/rsyslogd -iNONE && apache2-foreground