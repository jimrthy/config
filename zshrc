# Path to your oh-my-zsh configuration.
#ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Just because I like this one doesn't mean anyone else will
#ZSH_THEME="jimrthy"

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
# plugins=(git history lein tmux zsh-nvm)
# Q: Do I want any of those here?
# A: Almost definitely not, assuming
# I'm serious about switching to
# antigen

#source $ZSH/oh-my-zsh.sh
#ANTIGEN_CACHE_ENABLED="false"
#ANTIGEN_LOG=$HOME/antigen.log
source $HOME/tools/antigen/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
#antigen bundle pip
#antigen bundle lein
antigen bundle command-not-found
#antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle lukechilds/zsh-nvm

antigen theme https://github.com/jimrthy/config jimrthy --branch=main
antigen apply

# Customize to your needs...
export "PATH=$PATH:/usr/local/bin:$HOME/bin"

export EDITOR=vim
# Really depends on whether this is a python dev system or not
# It's pretty rare that I don't want this, though it's important to remember
# to install this via pip rather than any "standard" package manager
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh

# The docker version manager
# c.f. https://github.com/getcarina/dvm
#source $HOME/.dvm/dvm.sh

# This is a matter of taste. Some people actually like having their
# shells share all the history.
setopt inc_append_history
setopt no_share_history

[[ $TERM == "dumb" ]] && unsetopt zle && PS1="$ "

cowsay `fortune -a`
