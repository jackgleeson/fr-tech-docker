FROM python:3-slim-buster
COPY ./src /srv/myapp
RUN chmod -R +x /srv/myapp
WORKDIR /srv/myapp
EXPOSE 80
ENTRYPOINT [ "python", "-m", "http.server", "80"]