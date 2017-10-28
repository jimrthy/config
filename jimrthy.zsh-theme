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
    git branch >/dev/null 2>/dev/null && echo '�' && return
    hg root >/dev/null 2>/dev/null && echo '�' && return
    echo '� '
}

function hg_prompt_info {
   hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

USER='%{fg[blue]%}%n@%M%{$reset_color%}'
#LOCATION=' at %{fg[green]%}(collapse_pwd)%{reset_color%}
LOCATION=' at %{fg[green]%}${PWD/#$HOME/~}%{reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#PROMPT='
#$USER$LOCATION
#$(prompt_char) '

PROMPT='
%{$fg[blue]%}%n@%M%{$reset_color%} at %{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}
$(prompt_char) '

RPROMPT='$(check_last_exit_code)$(hg_prompt_info)$(git_prompt_info)'

