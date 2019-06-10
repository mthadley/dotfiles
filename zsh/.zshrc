#
# File: .zprofile
# Author: Michael T. Hadley (@mthadley)
#

# oh-my-zsh setup

## Path to your oh-my-zsh installation.

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(colored-man-pages git jump sudo vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

## Env
export PATH="$PATH:$HOME/.yarn/bin:$HOME/script:$HOME/.cargo/bin:$HOME/.local/bin"
export EDITOR=vim

## Aliases
alias gplog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

alias npr='npm run'
alias o='xdg-open'
alias tm='tmux -2'

## Nix
source ~/.nix-profile/etc/profile.d/nix.sh

## Direnv
eval "$(direnv hook zsh)"

## FZF
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--color=16"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
