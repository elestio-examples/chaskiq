#set env vars
set -o allexport; source .env; set +o allexport;

charset="A-Za-z0-9"
SECRET_KEY_BASE=$(cat /dev/urandom | tr -dc "$charset" | head -c 128)
MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY:-`openssl rand -hex 8`}
MINIO_SECRET_KEY=${MINIO_SECRET_KEY:-`openssl rand -hex 32`}

cat << EOT >> ./.env

SECRET_KEY_BASE=${SECRET_KEY_BASE}
MINIO_ROOT_USER=${MINIO_ACCESS_KEY}
MINIO_ROOT_PASSWORD=${MINIO_SECRET_KEY}
AWS_ACCESS_KEY_ID=${MINIO_ACCESS_KEY}
AWS_SECRET_ACCESS_KEY=${MINIO_SECRET_KEY}

EOT

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 5822,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT