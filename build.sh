#!/bin/sh
sudo apt-get install vim emacs zsh git tmux ssh

cp .gitconfig ~
cp .gitignore_global ~
mkdir ~/.ssh
cp open-wide.pem ~/.ssh
cp ssh.config ~/.ssh/config
cp .tmux.conf ~
cp .vimrc ~
cp .zshrc ~

