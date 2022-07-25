FROM node:18.6-bullseye

RUN apt update && apt upgrade -y

RUN npm install -g npm

RUN npm install -g serverless
RUN npm install -g serverless-step-functions
RUN npm install -g @vue/cli

COPY var/lib /var/tmp/lib

