#!/usr/bin/env bash
sed -i "s~ARG RUBY_VERSION~ARG RUBY_VERSION=3.2.0~g" Dockerfile
sed -i "s~ARG APP_ENV~ARG APP_ENV=production~g" Dockerfile
sed -i "s~ARG PG_MAJOR~ARG PG_MAJOR=11~g" Dockerfile
sed -i "s~ARG NODE_MAJOR~ARG NODE_MAJOR=16~g" Dockerfile
sed -i "s~ARG YARN_VERSION~ARG YARN_VERSION=1.13.0~g" Dockerfile
sed -i "s~ARG BUNDLER_VERSION~ARG BUNDLER_VERSION=2.3.26~g" Dockerfile
docker buildx build . --output type=docker,name=elestio4test/chaskiq:latest | docker load

charset="A-Za-z0-9"
SECRET_KEY_BASE=$(cat /dev/urandom | tr -dc "$charset" | head -c 128)

cat << EOT >> ./.env

SECRET_KEY_BASE=${SECRET_KEY_BASE}
SMTP_ADDRESS=tuesday.mxrouting.net
DEFAULT_SENDER_EMAIL=${SMTP_LOGIN}
SMTP_USERNAME=${SMTP_LOGIN}
SMTP_PASSWORD=${SMTP_PASSWORD}

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

rm post.txt