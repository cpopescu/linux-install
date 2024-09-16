## Setting up a new linux machine


1/ Install git (contents of [bin/install_first.sh](install_first.sh):
```sh
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git
```

2/ Install this repo
```sh
mkdir -p ~/src
cd ~/src
git clone https://github.com/cpopescu/linux-install.git
```

3/ Install base packages:
```sh
sudo ~/src/linux-install/bin/install_base.sh
```

4/ Install build tools (as user, requires some `sudo` internally):
```sh
~/src/linux-install/bin/install_tools.sh
```
Then update the env: `source ~/.bash

5/ *Optional*: Install cuda libs (on x64 architecutre):
```sh
~/src/linux-install/bin/install_cuda.sh
```


6/ *Optional*: Install test tools:
```sh
sudo ~/src/linux-install/bin/install_test_tools.sh
```
