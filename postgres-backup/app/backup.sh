#!/bin/sh

set -e

echo "Backup service starting..."

export STORJ_ACCESS_KEY=$STORJ_ACCESS_KEY
export STORJ_SECRET_KEY=$STORJ_SECRET_KEY
export PGPASSWORD=$POSTGRES_PASSWORD

# Wait for PostgreSQL to be ready
until pg_isready -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  echo "Waiting for PostgreSQL at $POSTGRES_HOST:$POSTGRES_PORT..."
  sleep 10
done

echo "PostgreSQL is ready. Configuring rclone for Storj..."

# Configure rclone remote for Storj
rclone config create storj s3 \
  provider "Other" \
  env_auth "false" \
  access_key_id "$STORJ_ACCESS_KEY" \
  secret_access_key "$STORJ_SECRET_KEY" \
  endpoint "$STORJ_ENDPOINT" \
  location_constraint ""

# Infinite backup loop
while true; do
  TIMESTAMP=$(date +%Y%m%d_%H%M%S)
  BACKUP_FILE="/tmp/postgres_backup_${TIMESTAMP}.sql"

  echo "Backing up database $POSTGRES_DB from $POSTGRES_HOST to $BACKUP_FILE..."
  pg_dump -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" > "$BACKUP_FILE"

  echo "Uploading to Storj bucket $STORJ_BUCKET..."
  rclone copy "$BACKUP_FILE" "storj:$STORJ_BUCKET/backups/"

  echo "Backup complete. Cleaning up..."
  rm -f "$BACKUP_FILE"

  echo "Backup successful. Sleeping 24 hours until next run..."
  sleep 86400
done
