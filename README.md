This document is to introduce how to build an IDE on Ubuntu environment.

You can do it follow the steps below:

1.make a bin directory to store your tools.

mkdir ~/bin/

echo "PATH=~/bin:\$PATH" >> ~/.bashrc

source ~/.bashrc

mkdir -p ~/tools/nvim_config/

cd ~/tools/nvim_config/

download this project here.

cp ~/tools/nvim_config/z.sh ~/bin/


2.install python3

python3 --version 

//require python3.8.after python3 is ready，install other python tools

sudo apt install python3-pip

sudo apt install python3-dev

sudo apt install python3-venv

pip3 install jedi

pip3 install jedi-language-server

pip3 install pynvim neovim

//offline to install pynvim to visit :https://pypi.org/

download:pynvim / msgpack / jedi

using command to install

pip3 install tools/msgpack-1.1.2.tar.gz

3.install fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install

after install has been finish,move the fzf.bash to ~/.fzf.bash

cp ~/tools/nvim_config/fzf.bash ~/.fzf.bash

echo "[ -f ~/.fzf.bash ] && source ~/.fzf.bash" >> ~/.bashrc

source ~/.bashrc


4.install tmux

sudo apt-get update

sudo apt-get install tmux

cp ~/tools/nvim_config/tmux.conf ~/.tmux.conf


5.install neovim

A).source code install neovim

mkdir -p ~/tools/nvim/

cd ~/tools/nvim/

git clone https://github.com/neovim/neovim.git

cd neovim/

make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/bin/ install

B).setup neovim environment && settings

echo "alias vim='nvim'" >> ~/.bashrc

echo "PATH=~/bin/bin:\$PATH" >> ~/.bashrc

source ~/.bashrc 

C).install neovim plugin manager

mkdir -p ~/.config/nvim/autoload/

curl -fLo ~/.config/nvim/autoload/plug.vim  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

D).edit neovim setting file

touch  ~/.config/nvim/init.vim

cp ~/tools/nvim_config/init.vim ~/.config/nvim/init.vim

E).install nvim plugins

input nvim to start it.

then press ":" into cmd mode,and input "PlugInstall" enter,wait for a while.press ":q" to exit after all plugins are done.

F).other tips:

neovim may need nodejs,so we have to install nodejs,this below is how to install nodejs:

方法一:

//离线安装node js

官网下载：

https://nodejs.org/zh-cn/download

下载 node-v16.20.2-linux-x64.tar.xz版本

拷贝到服务器，执行如下操作：

tar -xf node-v16.20.2-linux-x64.tar.xz

cp -r node-v16.20.2-linux-x64 ~/bin/

echo "PATH=~/bin/node-v16.20.2-linux-x64/bin:\$PATH" >> ~/.bashrc

方法二：

//install node

sudo apt install -y nodejs npm

sudo npm install n -g

sudo n stable

//install yarn

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update

sudo apt install yarn

node --version

npm --version

// setup to npm mirror inside GWF

sudo npm config set registry https://registry.npm.taobao.org

H).start nvim and check it

nvim

type in ":checkhealth" to check it.

environment will be fine when all items are ok.
