#!/usr/bin/bash

set -e

[[ ${USER} == "root" ]] && { echo "Please do not run as root"; exit 1; }

sudo apt-get install -y \
    nvidia-cuda-toolkit

UNAME=$(uname -m)
if [ "${UNAME}" == "aarch64" ]; then
    echo "Architecture not supported"
    exit 1
fi
CUDA_ARCH="x86_64"

echo ">>>>>>>>>>>>>>>>>>>> Install torch"
pipx install torch
