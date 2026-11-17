#!/bin/sh
set -e

echo "Waiting for postgres..."
until python -c "
import os, sys
import psycopg2
try:
    psycopg2.connect(
        host=os.getenv('DB_HOST', 'db'),
        port=os.getenv('DB_PORT', '5432'),
        dbname=os.getenv('POSTGRES_DB', 'taski'),
        user=os.getenv('POSTGRES_USER', 'taski_user'),
        password=os.getenv('POSTGRES_PASSWORD', 'taski'),
    )
except Exception as e:
    sys.exit(1)
sys.exit(0)
"; do
  sleep 1
done
echo "Postgres is up."

python manage.py migrate --noinput
python manage.py collectstatic --noinput

exec gunicorn backend.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3
