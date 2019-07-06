#
# File: My fish config
# Author: Michael T. Hadley (mikethadley@gmail.com)
#

fish_vi_key_bindings

bind -M insert -m default jk backward-char force-repaint

set -x EDITOR vim
set -x fish_greeting ''
set -x PATH $PATH "$HOME/.cargo/bin"

# aliases

alias npr 'npm run'
alias tm 'tmux -2'

## git
alias gd 'git diff'
alias gst 'git status'
alias gwch 'git whatchanged -p --abbrev-commit --pretty=medium'
alias gplog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"

# autojump
begin
    set -l autojump_path /usr/local/share/autojump/autojump.fish
    [ -f $autojump_path ]; and source $autojump_path
end

# Base16 Shell
if status --is-interactive
    eval sh $HOME/.config/base16-shell/scripts/base16-ocean.sh
end

# direnv
if command -s direnv > /dev/null
    direnv hook fish | source
end
