FROM python:3

RUN apt update && apt upgrade -y

RUN pip install --upgrade pip

COPY requirements.txt /var/tmp/requirements.txt
RUN pip install -r /var/tmp/requirements.txt

RUN pip install git+https://github.com/suzuki-navi/aws-glue-job-history

COPY var/lib /var/tmp/lib

