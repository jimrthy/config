# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Just because I like this one doesn't mean anyone else will
ZSH_THEME="jimrthy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export "PATH=$PATH:/usr/local/bin:$HOME/bin"

export EDITOR=vim
# Really depends on whether this is a python dev system or not
# It's pretty rare that I don't want this, though it's important to remember
# to install this via pip rather than any "standard" package manager
#source /usr/local/bin/virtualenvwrapper.sh

# The docker version manager
# c.f. https://github.com/getcarina/dvm
#source $HOME/.dvm/dvm.sh

# node.js version manager
#source $HOME/tools/nvm/nvm.sh

# This is a matter of taste. Some people actually like having their
# shells share all the history.
setopt inc_append_history
setopt no_share_history

cowsay `fortune -a`
