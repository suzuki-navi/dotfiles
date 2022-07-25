FROM ubuntu:22.04

COPY var/lib/ubuntu-hash /var/tmp

RUN apt update && apt upgrade -y

RUN apt install -y less postgresql-client-14

COPY var/lib /var/tmp/lib

