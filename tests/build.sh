#!/usr/bin/env bash
sed -i "s~ARG RUBY_VERSION~ARG RUBY_VERSION=3.2.0~g" Dockerfile
sed -i "s~ARG APP_ENV~ARG APP_ENV=production~g" Dockerfile
sed -i "s~ARG PG_MAJOR~ARG PG_MAJOR=11~g" Dockerfile
sed -i "s~ARG NODE_MAJOR~ARG NODE_MAJOR=16~g" Dockerfile
sed -i "s~ARG YARN_VERSION~ARG YARN_VERSION=1.13.0~g" Dockerfile
sed -i "s~ARG BUNDLER_VERSION~ARG BUNDLER_VERSION=2.3.26~g" Dockerfile
docker buildx build . --output type=docker,name=elestio4test/chaskiq:latest | docker load
