FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y sed && rm -rf /var/lib/apt/lists/*

COPY app.py /app/app.py
COPY checker.sed /app/checker.sed

RUN pip install flask

EXPOSE 8000

CMD ["python", "app.py"]
