#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./datastorage
chown 1000:1000 -R ./datastorage
chmod 777 -R ./datastorage

cat /opt/elestio/startPostfix.sh > post.txt
filename="./post.txt"

SMTP_LOGIN=""
SMTP_PASSWORD=""

# Read the file line by line
while IFS= read -r line; do
  # Extract the values after the flags (-e)
  values=$(echo "$line" | grep -o '\-e [^ ]*' | sed 's/-e //')

  # Loop through each value and store in respective variables
  while IFS= read -r value; do
    if [[ $value == RELAYHOST_USERNAME=* ]]; then
      SMTP_LOGIN=${value#*=}
    elif [[ $value == RELAYHOST_PASSWORD=* ]]; then
      SMTP_PASSWORD=${value#*=}
    fi
  done <<< "$values"

done < "$filename"




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