# config.fish
# Author: Michael T. Hadley (mikethadley@gmail.com)

fish_vi_key_bindings

bind -M insert -m default jk backward-char force-repaint

set -x EDITOR vim
set -x fish_greeting ''
set -x PATH $PATH "$HOME/.cargo/bin"

# aliases

alias aa 'ant all'
alias gsh 'telnet localhost 11311'
alias npr 'npm run'
alias tm 'tmux -2'

## git
alias gd 'git diff'
alias gst 'git status'
alias gwch 'git whatchanged -p --abbrev-commit --pretty=medium'
alias gplog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"
