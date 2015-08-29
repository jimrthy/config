#!/bin/sh

# This is called from inside bp.sh, so it really only
# needs to happen once. It's idempotent, so it won't
# hurt to call it multiple times, but it's a useless
# time sink
sudo apt-get install -y emacs24 \
                        git \
                        python-dev \
                        python-pip \
                        ssh \
                        tmux \
                        vim  \
                        zsh 

cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global 
if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh;
fi

echo "Setting up oh-my-zsh"
wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
cp jimrthy.zsh-theme ~/.oh-my-zsh/themes
cp ~/.zshrc ~/zshrc.original
cp zshrc ~/.zshrc 

cp tmux.conf ~/.tmux.conf 
cp vimrc ~/.vimrc 


chsh -s /usr/bin/zsh

