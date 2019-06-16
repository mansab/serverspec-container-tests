FROM python:3.7-alpine3.9

RUN adduser -D -h /app -s /bin/sh -G root app-user

ADD app /app

RUN chmod 644 /app/index.py && \
    chown -R app-user:root /app

WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 5000

USER app-user

CMD python ./index.py
