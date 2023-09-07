#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

docker-compose exec -T server bash -c "rails db:create"
docker-compose exec -T server bash -c "rails db:schema:load"
docker-compose exec -T server bash -c "rails db:seed"
docker-compose exec -T server bash -c "rake admin_generator"


apt install -y redis-tools

#register the local server in the web ui
redis_insight_target=$(docker-compose port redisinsight 8001)
curl --output /dev/null --header "Content-Type: application/json" \
 --request POST --data '{ "name": "local", "connectionType": "STANDALONE", "host": "redis","port": 6379,"password": "'"$SOFTWARE_PASSWORD"'"}' \
 http://$redis_insight_target/api/instance/