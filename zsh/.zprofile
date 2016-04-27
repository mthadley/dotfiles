# zprofile - Mike Hadley

# Env
export PATH="$PATH:$HOME/Scripts:$HOME/.rakudobrew/bin"
export ANT_OPTS=-Xmx1024m

# Aliases

## General

alias gplog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"
alias npr='npm run'
alias o='xdg-open'
alias tm='tmux -2'

## Liferay

alias aa='ant all'
alias aac='(cd ~/Liferay/liferay-plugins-ee/portlets/loop-portlet && aa && cd ~/Liferay/liferay-plugins-ee/themes/loop-theme && aa)'
alias csf='git ls-files -m | xargs check_sf'

# Subs

gpp() {
	[[ -z $1 ]] && 1='upstream'
	[[ -z $2 ]] && 2=$(git rev-parse --abbrev-ref HEAD)

	git pull "$1" "$2" && git push origin "$2"
}

lsl() {
	NAME='bundle.nocsf.js'
	SRC="/Users/mike/Liferay/liferay-plugins-ee/portlets/loop-portlet/docroot/js/dist/$NAME"
	DST="/Users/mike/Liferay/bundles-ee/tomcat-7.0.54/webapps/loop-portlet/js/dist/$NAME"

	[[ -e "$DST" ]] && rm "$DST"

	echo "Linking $NAME"
	ln -F "$SRC" "$DST"
}
