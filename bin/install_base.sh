#!/usr/bin/bash

set -e


[[ ${USER} == "root" ]] || { echo "Please run as root"; exit 1; }

apt-get update

echo ">>>>>>>>>>>>>>>>>>>> Installing packages"
apt-get install -y \
    git-lfs \
    clang \
    gcc \
    g++ \
    wget \
    perl \
    make \
    patch \
    python3.12 \
    python3.12-dev \
    sudo \
    adduser \
    golang-1.21 \
    tzdata \
    pipx \
    curl \
    gpg \
    apt-transport-https \
    ca-certificates \
    jq \
    gnupg

git lfs install

echo ">>>>>>>>>>>>>>>>>>>> Installing bazelisk"
UNAME=$(uname -m)
if [ "${UNAME}" == "aarch64" ]; then
    ARCH="arm64"
    SHA256="a836972b8a7c34970fb9ecc44768ece172f184c5f7e2972c80033fcdcf8c1870"
else
    ARCH="amd64"
    SHA256="61699e22abb2a26304edfa1376f65ad24191f94a4ffed68a58d42b6fee01e124"
fi

FNAME="bazelisk-linux-${ARCH}"
wget "https://github.com/bazelbuild/bazelisk/releases/download/v1.17.0/${FNAME}"
FSUM=$(sha256sum ${FNAME})
if [ "${FSUM}" != "${SHA256}  ${FNAME}" ]; then
    echo "Invalid SHA256 sum: ${FSUM} vs. ${SHA256}"
    exit 1
fi
mv ${FNAME} /usr/bin/bazel
chmod a+x /usr/bin/bazel

ln -sf /usr/bin/python3.12 /usr/bin/python3
hash -r

echo ">>>>>>>>>>>>>>>>>>>> Setup paths"
export PATH="${PATH}:~/.local/bin"
echo 'export PATH="${PATH}:~/.local/bin"' >> ~/.bashrc
echo 'PATH="${PATH}:/usr/lib/go-1.21/bin/:${HOME}/go/bin"' >> ~/.bashrc
# Small hack: Force .bashrc to execute the rest of the file even if not interactive
sed -i.bak 's/return;;/;;\#return;;/g' ~/.bashrc
