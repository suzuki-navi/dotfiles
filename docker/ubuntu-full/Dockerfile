FROM ubuntu:22.04

COPY var/lib/ubuntu-hash /var/tmp

RUN apt update && apt upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata

RUN apt install -y sudo
RUN echo '%sudo ALL=NOPASSWD: ALL' >> /etc/sudoers
RUN echo 'Set disable_coredump false' >> /etc/sudo.conf

RUN echo y | unminimize

RUN apt install -y nkf

COPY var/lib /var/tmp/lib

