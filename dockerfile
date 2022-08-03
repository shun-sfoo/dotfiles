FROM alpine:3.14
RUN apk add make
COPY . /app
WORKDIR /app
