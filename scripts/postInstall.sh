#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

docker-compose exec -T server bash -c "rails db:create"
docker-compose exec -T server bash -c "rails db:schema:load"
docker-compose exec -T server bash -c "rails db:seed"
docker-compose exec -T server bash -c "rake admin_generator"

