#!/usr/bin/bash

set -e

[[ ${USER} == "root" ]] && { echo "Please do not run as root"; exit 1; }

echo ">>>>>>>>>>>>>>>>>>>> Install bigquery emulator"

## This takes a long time to build, as we install it from source
source ~/.bashrc && export CGO_ENABLED=1 && export CXX=clang++ && export CC=clang && go install github.com/goccy/bigquery-emulator/cmd/bigquery-emulator@latest

echo ">>>>>>>>>>>>>>>>>>>> Install bigtable emulator"
sudo apt-get install -y google-cloud-cli-bigtable-emulator

echo ">>>>>>>>>>>>>>>>>>>> Install libraries for browser tests"
sudo apt-get install -y \
    libglib2.0-0t64 \
    libnss3 \
    libnspr4 \
    libdbus-1-3 \
    libatk1.0-0t64 \
    libatk-bridge2.0-0t64 \
    libcups2t64 \
    libdrm2 \
    libxkbcommon0 \
    libatspi2.0-0t64 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2t64

# Note: we also need to install npm and playwright.
#   Normally bazel would install them on run, but, they get installed under
#   user directory ~/.cache/ms-playright/....
#   Having a bazel cache during the build process, that does not capture that
#   particular directory, would make bazel ignore reinstallation, because the
#   (bazel) cache says they are installed, but actually they are not captured
#   in the bazel cache leading to errors. So we install them directly in
#   the image to avoid this issue.
#
sudo apt-get install -y npm
yes | npx playwright install

echo "DONE"
