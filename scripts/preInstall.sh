#set env vars
set -o allexport; source .env; set +o allexport;

charset="A-Za-z0-9"
SECRET_KEY_BASE=$(cat /dev/urandom | tr -dc "$charset" | head -c 128)

cat << EOT >> ./.env

SECRET_KEY_BASE=${SECRET_KEY_BASE}
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