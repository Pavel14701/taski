FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN pip install --no-cache-dir gunicorn==23.0.0

COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt psycopg2-binary==2.9.11

COPY backend/docker-entrypoint.sh .
COPY backend/manage.py .
COPY backend/backend ./backend
COPY backend/api ./api

RUN chmod +x docker-entrypoint.sh \
    && mkdir -p /app/static /app/media

ENTRYPOINT ["./docker-entrypoint.sh"]
