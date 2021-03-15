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
-keyout /etc/ssl/certs/civicrm.key \
-out /etc/ssl/certs/civicrm.crt \
-days 1095

# Build CiviCRM environment
FROM php:7.3-apache-buster
RUN apt-get update && apt-get install -y \
git \
iproute2 \
libc-client-dev \
libicu-dev \
libjpeg62-turbo-dev \
libkrb5-dev \
libmagickwand-dev \
libpng-dev \
libxml2-dev \
msmtp-mta \
default-mysql-client \
nodejs \
sudo \
unzip \
zip \
libzip-dev \
nano \
less

RUN docker-php-ext-install bcmath \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install gettext \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-install intl \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && docker-php-ext-install zip

RUN pecl install imagick \
    && pecl install xdebug \
    && pecl install redis-5.1.1 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable redis

ARG user_id
ARG group_id
RUN addgroup --gid=$group_id docker
RUN useradd --home-dir /docker --create-home --uid $user_id --gid $group_id docker

COPY ./docker /docker/
RUN chown -R docker /docker

COPY ./docker/php.ini /usr/local/etc/php/php.ini
COPY ./docker/xdebug.ini /usr/local/etc/php/conf.d/_xdebug.ini
RUN touch /var/log/xdebug.log
RUN chown docker /var/log/xdebug.log

# let's use a tag here
COPY --chown=docker src /var/www/html/
COPY ./docker/drush.sh /usr/local/bin/drush
COPY ./docker/config/smashpig/public/ /etc/smashpig/
RUN mkdir /var/spool/prometheus && chown docker /var/spool/prometheus

WORKDIR /docker
RUN git clone https://gerrit.wikimedia.org/r/wikimedia/fundraising/crm/civicrm-buildkit
RUN /docker/civicrm-buildkit/bin/civi-download-tools
ENV PATH="${PATH}:/docker/civicrm-buildkit/bin"

COPY --from=cert_builder /etc/ssl/certs/ /etc/ssl/certs/
COPY ./docker/civicrm.ssl.conf /etc/apache2/sites-available/
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl
RUN service apache2 restart
RUN a2dissite 000-default.conf
RUN a2ensite civicrm.ssl.conf

WORKDIR /tmp
RUN curl --silent --fail --output composer.phar https://getcomposer.org/download/1.10.5/composer.phar \
    && sha256sum -c /docker/composer.phar.sha256sum \
    && chmod +x /tmp/composer.phar \
    && mv /tmp/composer.phar /usr/bin/composer

WORKDIR /var/www/html
EXPOSE 8002

