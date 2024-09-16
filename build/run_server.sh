#!/usr/bin/bash

mkdir -p ~/logs

function start_server {
    echo "Starting worker"
    cd ~/src/bazel-buildfarm
    bazel run //src/main/java/build/buildfarm:buildfarm-server \
          -- --jvm_flag=-Djava.util.logging.config.file=${PWD}/examples/logging.properties \
          ${PWD}/examples/config.minimal.yml > ~/logs/worker.log 2>&1 &
}

curl -s http://localhost:9090/health > /dev/null || start_server
