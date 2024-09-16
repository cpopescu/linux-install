#!/usr/bin/bash

mkdir -p ~/logs

function start_worker {
    echo "Starting worker"
    cd ~/src/bazel-buildfarm
    bazel run //src/main/java/build/buildfarm:buildfarm-shard-worker -- \
          --prometheus_port=9091 \
          ${PWD}/examples/config.minimal.yml > ~/logs/worker.log 2>&1 &
}

curl -s http://localhost:9091/health > /dev/null || start_worker
