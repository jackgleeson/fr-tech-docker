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
-keyout /etc/ssl/certs/smashpig.key \
-out /etc/ssl/certs/smashpig.crt \
-days 1095

# Build SmashPig environment
FROM php:7.4-apache-buster
RUN apt-get update && apt-get install -y mariadb-client \
curl \
git \
unzip \
sudo \
rsyslog \
libsodium-dev \
zlib1g-dev \
libzip-dev \
libc-client-dev \
libicu-dev \
libxml2-dev \
nano \
less

RUN docker-php-ext-install mysqli \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath

RUN pecl install redis-5.1.1 \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable redis

ARG user_id
ARG group_id
RUN addgroup --gid=$group_id docker
RUN useradd --home-dir /docker --create-home --uid $user_id --gid $group_id docker

# let's use a tag instead
COPY ./src /var/www/html/
COPY ./docker /docker/
RUN chown -R docker /docker

COPY ./docker/rsyslog.conf /etc/rsyslog.conf
COPY ./docker/php.ini /usr/local/etc/php/php.ini
COPY ./docker/xdebug.ini /usr/local/etc/php/conf.d/_xdebug.ini
RUN touch /var/log/xdebug.log
RUN chown docker /var/log/xdebug.log

COPY ./docker/config/smashpig/public/ /etc/smashpig/
COPY ./docker/config/smashpig/private/ /etc/smashpig/

COPY --from=cert_builder /etc/ssl/certs/ /etc/ssl/certs/
COPY ./docker/smashpig.ssl.conf /etc/apache2/sites-available/
RUN a2enmod ssl
RUN a2enmod rewrite
RUN service apache2 restart
RUN a2dissite 000-default.conf
RUN a2ensite smashpig.ssl.conf

WORKDIR /tmp
RUN curl --silent --fail --output composer.phar https://getcomposer.org/download/1.10.5/composer.phar \
    && sha256sum -c /docker/composer.phar.sha256sum \
    && chmod +x /tmp/composer.phar \
    && mv /tmp/composer.phar /usr/bin/composer

WORKDIR /var/www/html
EXPOSE 8000

ENTRYPOINT /usr/sbin/rsyslogd -iNONE && apache2-foreground