#!/bin/sh

cd /app || exit 1

terraform apply -var "username=$OS_USERNAME" -var "password=$OS_PASSWORD" -var "tenant=$OS_TENANT_NAME" -var "auth_url=$OS_AUTH_URL"
