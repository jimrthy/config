#!/bin/sh

# This is called from inside bp.sh, so it really only
# needs to happen once. It's idempotent, so it won't
# hurt to call it multiple times, but it's a useless
# time sink
sudo apt-get install vim emacs zsh git tmux ssh svn

cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global 
mkdir ~/.ssh
cp open-wide.pem ~/.ssh
cp ssh.config ~/.ssh/config
cp tmux.conf ~/.tmux.conf 
cp vimrc ~/.vimrc 
cp zshrc ~/.zshrc 

