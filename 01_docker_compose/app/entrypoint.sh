#!/bin/sh

echo "Waiting for postgres..."

while ! nc -z $DB_HOST $DB_PORT; do
  sleep 0.5
done

echo "PostgreSQL started"

echo "Apply DB migrations"

python manage.py flush --no-input

python manage.py migrate

python manage.py collectstatic --noinput

gunicorn config.wsgi:application --bind 0.0.0.0:8000