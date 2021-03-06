#!/usr/bin/env bash

GUNICORN_WORKERS="${GUNICORN_WORKERS:-4}"
GUNICORN_PORT=8000

set -x

gunicorn \
    --workers="$GUNICORN_WORKERS" \
    --bind=0.0.0.0:"$GUNICORN_PORT" \
    uservice_django_poc.wsgi:application