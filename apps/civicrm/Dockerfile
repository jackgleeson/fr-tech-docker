FROM php:7.4-buster
COPY ./src /srv/myapp
RUN chmod -R +x /srv/myapp
WORKDIR /srv/myapp
EXPOSE 80
ENTRYPOINT [ "php", "-S", "0.0.0.0:80"]