FROM ubuntu:22.04 as installer

COPY var/lib/ubuntu-hash /var/tmp

RUN apt update && apt upgrade -y

RUN apt install -y curl zip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscli-exe-linux-x86_64.zip
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install --bin-dir /aws-cli-bin/

FROM ubuntu:22.04

COPY var/lib/ubuntu-hash /var/tmp

RUN apt update && apt upgrade -y

RUN echo y | unminimize

COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=installer /aws-cli-bin/ /usr/local/bin/

COPY var/lib /var/tmp/lib

