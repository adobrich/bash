# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

[ -n "$PS1" ] && . ~/.bash_profile

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
