#!/usr/bin/env bash
docker-compose up -d;
sleep 60s;

docker-compose exec -T server bash -c "rails db:create"
docker-compose exec -T server bash -c "rails db:schema:load"
docker-compose exec -T server bash -c "rails db:seed"
docker-compose exec -T server bash -c "rake admin_generator"