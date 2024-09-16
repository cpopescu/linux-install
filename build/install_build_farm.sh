#!/usr/bin/bash

set -e

sudo apt-get install -y redis-tools

cd ~/src
git clone https://github.com/bazelbuild/bazel-buildfarm
