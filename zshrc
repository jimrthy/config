# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Just because I like this one doesn't mean anyone else will
ZSH_THEME="jimrthy"
#ZSH_THEME="random"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export "PATH=$PATH:/usr/local/bin:$HOME/bin"

export EDITOR=vim
#source /usr/local/bin/virtualenvwrapper.sh

# This is a matter of taste. Some people actually like having their
# shells share all the history.
setopt inc_append_history
setopt no_share_history

cowsay `fortune -a`
