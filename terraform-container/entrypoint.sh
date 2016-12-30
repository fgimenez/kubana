#!/bin/sh

cd /app || exit 1

if [ -z "$1" ]; then
    cmd=apply
    force=
else
    cmd="$1"
    if [ "$1" = destroy ]; then
        force="--force"
    fi
fi

eval "terraform $cmd $force -var username=$OS_USERNAME -var password=$OS_PASSWORD -var tenant=$OS_TENANT_NAME -var auth_url=$OS_AUTH_URL"
