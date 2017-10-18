#function collapse_pwd {
   #echo $(pwd | sed -e "s,^$HOME,~,")
#}

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '¿' && return
    echo '» '
}

function hg_prompt_info {
   hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( â†’ )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function _git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
  echo "${ref/refs\/heads\//⭠ }$(parse_git_dirty)"
}

function _git_info() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    local BG_COLOR=green
    if [[ -n $(parse_git_dirty) ]]; then
      BG_COLOR=yellow
      FG_COLOR=black
    fi

    if [[ ! -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        BG_COLOR=red
        FG_COLOR=white
    fi
    echo "%{%K{$BG_COLOR}%}⮀%{%F{$FG_COLOR}%} $(_git_prompt_info) %{%F{$BG_COLOR}%K{blue}%}"⮀
  else
    echo "%{%K{blue}%}⮀"
  fi
}

function _git_prefix_info() {
  local BG_COLOR=yellow
  local FG_COLOR=black
  if [[ -z $(parse_git_dirty) ]]; then
#    echo "(clean)"⮀
    BG_COLOR=green
  fi

  if [[ ! -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
      BG_COLOR=red
      FG_COLOR=white
  fi
#  echo "%{%K{$BG_COLOR}%}†%{%F{$FG_COLOR}%} $(_git_prompt_info) %{%F{$BG_COLOR}%K{blue}%}†"  
  echo "%{%K{$BG_COLOR}%}†%{%F{$FG_COLOR}%}"
}

#ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
# Sadly for my wants/desires, this doesn't get re-evaled each time.
# 
ZSH_THEME_GIT_PROMPT_PREFIX=$(_git_prefix_info)
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} dirty!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#LOCATION=' at %{fg[green]%}(collapse_pwd)%{reset_color%}
LOCATION=' at %{fg[green]%}${PWD/#$HOME/~}%{reset_color%}'
#PROMPT='
#$USER$LOCATION
#$(prompt_char) '

PROMPT='
%{$fg[blue]%}%n@%M%{$reset_color%} at %{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}
$(prompt_char) '
# This kind of approach still doesn't work
# (the percentage signs don't escape correctly)
#PROMPT="
#%{$fg[blue]%}%n@%M%{$reset_color%} ${LOCATION}
#$(prompt_char) "

RPROMPT='$(check_last_exit_code)$(hg_prompt_info)$(_git_info)'

