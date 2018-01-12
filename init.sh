#!/bin/sh

export DB_ADMIN_USERNAME="ztadmin"
export DB_ADMIN_PASSWORD="secret"
export DATABASE_HOST="localhost"
export DATABASE_NAME="ci24siete"

docker stop postgres
#rm -rf vendor/ tmp/
sleep 5

docker run -d --name postgres --rm -p 5432:5432 -e POSTGRES_DB=${DATABASE_NAME} -e POSTGRES_USER=${DB_ADMIN_USERNAME} -e POSTGRES_PASSWORD=${DB_ADMIN_PASSWORD} postgres
#bundle
bundle update --source pwb

rails pwb:install:migrations
rails db:create
rails db:migrate
rails pwb:db:seed
rails pwb:db:seed_pages

rails server
