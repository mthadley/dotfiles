# zshrc - Mike Hadley

# oh-my-zsh setup

## Path to your oh-my-zsh installation.

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(colored-man-pages git jump sudo vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration
#
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--color=16"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export PATH="$HOME/.yarn/bin:$PATH"
