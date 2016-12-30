#!/bin/sh

cd /app || exit 1

if [ -z "$1" ]; then
    cmd=apply
else
    cmd="$1"
fi

terraform "$cmd" -var "username=$OS_USERNAME" -var "password=$OS_PASSWORD" -var "tenant=$OS_TENANT_NAME" -var "auth_url=$OS_AUTH_URL"
