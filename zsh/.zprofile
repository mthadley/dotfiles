# zprofile - Mike Hadley

# Env
export ANT_OPTS="-Xms4096M -Xmx4096M -XX:MaxPermSize=1024M -XX:-UseGCOverheadLimit"
export EDITOR=vim
export PATH="$PATH:$HOME/Scripts:$HOME/.rakudobrew/bin:$HOME/.cargo/bin:$HOME/.local/bin"

# Aliases

## General

alias gplog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"
alias gsh='telnet localhost 11311'
alias npr='npm run'
alias o='xdg-open'
alias tm='tmux -2'

# Functions

function gw {
	local root_level=$(git rev-parse --show-toplevel 2>/dev/null)

	if [[ -n "$root_level" && -f "$root_level/gradlew" ]]; then
		root_level="$root_level/gradlew"
	else
		root_level=$(which gradle)
	fi

	"$root_level" $@
}
