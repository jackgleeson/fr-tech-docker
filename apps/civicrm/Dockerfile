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

# Install php extensions (curl, json, mbstring, openssl, posix, phar
# are installed already and don't need to be specified here)
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
    && docker-php-ext-enable imagick

RUN addgroup --gid=1000 runuser
RUN useradd --home-dir /runuser --create-home --uid 1000 --gid 1000 runuser

COPY docker/php.ini /usr/local/etc/php/php.ini
COPY docker /docker/
COPY --chown=www-data:root src /var/www/html/
COPY docker/drush.sh /usr/local/bin/drush
COPY --chown=www-data:root docker/config/drupal /var/www/html/sites/default/
COPY ./docker/config/smashpig/public/ /etc/smashpig/

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

