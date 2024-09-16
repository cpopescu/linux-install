## Setting up a new linux machine


1/ Install git (contents of [bin/install_first.sh](install_first.sh):
```sh
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git
```

2/ Install this repo
```sh
mkdir ~/src && cd ~/src
git clone https://github.com/cpopescu/linux-install.git
cd linux-install
```

3/ Install base tools:
```sh
sudo ~/src/linux-install/bin/install_base.sh
```

4/ *Optional*: Install cuda libs (on x64 architecutre):
```sh
sudo ~/src/linux-install/bin/install_cuda.sh
```

5/ Install build tools (as user, requires some `sudo` internally):
```sh
sudo ~/src/linux-install/bin/install_tools.sh
```

6/ *Optional*: Install test tools:
```sh
sudo ~/src/linux-install/bin/install_test_tools.sh
```
