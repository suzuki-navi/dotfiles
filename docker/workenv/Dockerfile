FROM ubuntu:22.04

COPY var/lib/ubuntu-hash /var/tmp

RUN apt update && apt upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata

RUN apt install -y sudo
RUN echo '%sudo ALL=NOPASSWD: ALL' >> /etc/sudoers
RUN echo 'Set disable_coredump false' >> /etc/sudo.conf

RUN echo y | unminimize

RUN apt install -y docker docker.io

RUN apt install -y locales-all git zsh tmux less curl zip nkf peco make

# locales-all は
# lsのファイル名ソートを自然な順にするためと
# perlで以下のwarningが出てしまうのを防ぐため
# perl: warning: Setting locale failed.
# perl: warning: Please check that your locale settings:
#         LANGUAGE = (unset),
#         LC_ALL = (unset),
#         LANG = "en_US.UTF-8"
#     are supported and installed on your system.
# perl: warning: Falling back to the standard locale ("C").

COPY var/lib /var/tmp/lib

