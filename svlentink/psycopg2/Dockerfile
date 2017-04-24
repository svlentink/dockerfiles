FROM python:alpine
# https://github.com/hack4impact/flask-base/issues/96
# https://bugs.alpinelinux.org/issues/3642
RUN apk add --no-cache py-pip postgresql-dev gcc g++
RUN pip install psycopg2
