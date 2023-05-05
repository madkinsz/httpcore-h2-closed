#!/usr/bin/env bash

set -x

docker exec -it nginx-proxy bash -c 'nginx -s reload'
