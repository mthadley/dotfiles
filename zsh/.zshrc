# zshrc - Mike Hadley

# oh-my-zsh setup

## Path to your oh-my-zsh installation.

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git sublime jump sudo web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

export FZF_DEFAULT_OPTS="--color=16"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
