#
# File: .zprofile
# Author: Michael T. Hadley (@mthadley)
#

# vi keybinds
# bindkey -v

# Env
export EDITOR=vim
export PATH="$PATH:$HOME/Scripts:$HOME/.cargo/bin:$HOME/.local/bin"

# Aliases

## General

### git
alias gplog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

### misc
alias npr='npm run'
alias o='xdg-open'
alias tm='tmux -2'

## Nix
source ~/.nix-profile/etc/profile.d/nix.sh

## Direnv
eval "$(direnv hook zsh)"

# ruby - Disabled in favor of nix
# if [ -d /usr/local/opt/chruby/share/chruby ]; then
#   source /usr/local/opt/chruby/share/chruby/chruby.sh
#   source /usr/local/opt/chruby/share/chruby/auto.sh

#   if [ -e .ruby-version ]; then
#     chruby $(cat .ruby-version)
#   fi
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
