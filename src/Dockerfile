FROM docker:26-cli

WORKDIR /app

RUN apk add --no-cache python3 py3-pip

RUN pip3 install flask

COPY server.py /app/server.py

CMD ["python3", "/app/server.py"]

