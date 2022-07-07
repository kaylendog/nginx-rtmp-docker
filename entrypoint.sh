#!/bin/bash
set -euo pipefail

export DOLLAR='$'
envsubst < /etc/nginx/nginx.conf > /etc/nginx/nginx.subst.conf
nginx -t -c /etc/nginx/nginx.subst.conf
exec nginx -g "daemon off;" -c /etc/nginx/nginx.subst.conf
