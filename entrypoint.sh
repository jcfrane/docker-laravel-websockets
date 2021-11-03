#!/bin/sh
set -e

envsubst < .env.example > .env
exec "$@"
