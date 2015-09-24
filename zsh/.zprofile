# zprofile - Mike Hadley

# Env
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/Scripts"
export ANT_OPTS=-Xmx1024m

# Aliases

## General

alias gplog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"
alias tm='tmux -2'
alias o='xdg-open'

if command -v nvim >/dev/null 2>&1; then
	alias vim='nvim'
fi

## Liferay

alias jr='jira $(git rev-parse --abbrev-ref HEAD)'
alias aa='ant all'
alias aac='(cd ~/Liferay/liferay-plugins-ee/portlets/loop-portlet && aa && cd ~/Liferay/liferay-plugins-ee/themes/loop-theme && aa)'
alias csf='git ls-files -m | xargs check_sf'

# Subs

gpp() {
	[[ -z $1 ]] && 1=$(git rev-parse --abbrev-ref HEAD)

	git pull upstream "$1" && git push origin "$1"
}
