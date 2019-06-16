FROM python:3.7-alpine3.9

RUN adduser -D -h /app -s /bin/sh -G root app-user

ADD app /app

RUN chmod 644 /app/index.py && \
    chown -R app-user:root /app
