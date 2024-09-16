#!/usr/bin/bash

function start_redis {
    echo "Starting Redis"
    docker run -d --rm --name buildfarm-redis -p 6379:6379 redis:7.2.4
}

redis-cli -h localhost -p 6379 ping  || start_redis
