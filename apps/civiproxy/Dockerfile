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
-keyout /etc/ssl/certs/civiproxy.key \
-out /etc/ssl/certs/civiproxy.crt \
-days 1095

# Build SmashPig environment
FROM php:7.4-apache-buster
RUN apt-get update && apt-get install -y curl \
default-mysql-client \
git \
unzip \
sudo \
nano \
less

RUN pecl install xdebug && docker-php-ext-enable xdebug

ARG user_id
ARG group_id
RUN addgroup --gid=$group_id docker
RUN useradd --home-dir /docker --create-home --uid $user_id --gid $group_id docker

# let's use a tag instead
COPY ./src/proxy/ /var/www/html
COPY ./docker /docker/
RUN chown -R docker /docker

# xdebug
COPY ./docker/php.ini /usr/local/etc/php/php.ini
COPY ./docker/xdebug.ini /usr/local/etc/php/conf.d/_xdebug.ini
RUN touch /var/log/xdebug.log
RUN chown docker /var/log/xdebug.log

COPY --from=cert_builder /etc/ssl/certs/ /etc/ssl/certs/
COPY ./docker/civiproxy.ssl.conf /etc/apache2/sites-available/
RUN a2enmod ssl
RUN service apache2 restart
RUN a2dissite 000-default.conf
RUN a2ensite civiproxy.ssl.conf

WORKDIR /var/www/html
EXPOSE 8000