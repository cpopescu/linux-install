#!/usr/bin/bash

set -e

[[ ${USER} == "root" ]] && { echo "Please do not run as root"; exit 1; }

echo ">>>>>>>>>>>>>>>>>>>> Setup paths"
export PATH="${PATH}:${HOME}/.local/bin:/usr/lib/go-1.21/bin/:${HOME}/go/bin"
echo 'export PATH="${PATH}:${HOME}/.local/bin:/usr/lib/go-1.21/bin/:${HOME}/go/bin"' >> ~/.bashrc
# Small hack: Force .bashrc to execute the rest of the file even if not interactive
sed -i.bak 's/return;;/;;\#return;;/g' ~/.bashrc
source ~/.bashrc

echo ">>>>>>>>>>>>>>>>>>>> Install latest pipx version:"
pipx install pipx
sudo apt purge -y --autoremove pipx

source ~/.bashrc

echo ">>>>>>>>>>>>>>>>>>>> Install tools:"
sudo apt-get install -y \
     clang-format shfmt emacs
pipx install poetry
pipx install black
pipx ensurepath

go install github.com/bazelbuild/buildtools/buildifier@latest

echo 'PATH="${PATH}:${HOME}/go/bin"' >> ~/.bashrc

source ~/.bashrc


DOCKER_VERSION="4.27.1"
echo ">>>>>>>>>>>>>>>>>>>> Install Docker ${DOCKER_VERSION}:"

mkdir -p ~/Downloads
cd ~/Downloads
sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


# Add the repository to Apt sources:
ARCH=$(dpkg --print-architecture)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y \
     docker-ce \
     docker-ce-cli \
     containerd.io \
     docker-buildx-plugin \
     docker-compose-plugin
curl -o "docker-desktop-${DOCKER_VERSION}-${ARCH}.deb" \
     "https://desktop.docker.com/linux/main/${ARCH}/136059/docker-desktop-${DOCKER_VERSION}-${ARCH}.deb"
sudo dpkg -i "docker-desktop-${DOCKER_VERSION}-${ARCH}.deb" || true
sudo apt-get –fix-broken install || true


echo "Installing google cloud client"

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg |
    sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt-get update
sudo apt-get install -y google-cloud-cli
