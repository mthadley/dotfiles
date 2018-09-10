# zshrc - Mike Hadley

# oh-my-zsh setup

## Path to your oh-my-zsh installation.

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(colored-man-pages git sublime jump sudo web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

export FZF_DEFAULT_OPTS="--color=16"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/perl5/perlbrew/etc/bashrc ] && source ~/perl5/perlbrew/etc/bashrc

export PATH="$HOME/.yarn/bin:$PATH"
