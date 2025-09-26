# Akash Postgres Backup

A Postgres server running on Akash with 24-hourly backups. Backups are stored in Storj.

This is a two-container configuration: one PostgreSQL server and one scheduled database backup container on boot and then every 24 hours.

## Usage

- Setup a [Storj](https://www.storj.io/) credentials. `STORJ_ACCESS_KEY`, `STORJ_SECRET_KEY` and `STORJ_BUCKET`.
- Set the environment variables in the [deploy_persistent.yaml](https://github.com/laserkit/awesome-akash/blob/postgres-backup/postgres-backup/deploy_persistent.yaml) for persistent storage or [deploy_shm.yaml](https://github.com/laserkit/awesome-akash/blob/postgres-backup/postgres-backup/deploy_shm.yaml) for RAM storage and deploy on Akash.
- Use the URL and port Akash gives you to connect to the Postgres server, with the credentials you provided in the environment variables.

## Environment variables

- `POSTGRES_USER=postgres` - your Postgres server username
- `POSTGRES_PASSWORD=password` - your Postgres server password
- `POSTGRES_DB=postgres` - name of your database
- `POSTGRES_HOST=postgres` - Postgres server host
- `POSTGRES_PORT=5432` - Postgres port
- `STORJ_BUCKET=bucket` - bucket for backups
- `STORJ_ACCESS_KEY=key` - your Storj access key
- `STORJ_SECRET_KEY=secret` - your Storj secret key
