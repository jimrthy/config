# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Just because I like this one doesn't mean anyone else will
ZSH_THEME="jimrthy"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# TODO: Experiment with this
# (I strongly suspect I actually do want it)
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# TODO: Experiment with this
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Home configuration is
# plugins=(git history lein tmux)
# Q: Do I want any of those here?
plugins=(git zsh-nvm)

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

[[ $TERM == "dumb" ]] && unsetopt zle && PS1="$ "

cowsay `fortune -a`
