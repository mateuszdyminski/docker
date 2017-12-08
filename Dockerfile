FROM golang:1.9.2-alpine

RUN mkdir -p /usr/share/http

WORKDIR /usr/share/http

ADD http /usr/share/http

COPY statics ./statics

COPY config ./config

VOLUME /usr/share/http/config

EXPOSE 9090

EXPOSE 8080

RUN chmod +x /usr/share/http/http

ENTRYPOINT /usr/share/http/http -config=/usr/share/http/config/config.toml
