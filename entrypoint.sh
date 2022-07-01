#!/usr/bin/bash
set -euo pipefail

export DOLLAR='$'
echo $(envsubst < /etc/nginx/nginx.conf) > /etc/nginx/nginx.conf
nginx -t
exec nginx -g "daemon off;"
