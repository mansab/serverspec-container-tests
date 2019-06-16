FROM python:3.7-alpine3.9

ADD app /app

RUN chmod 644 /app/index.py
