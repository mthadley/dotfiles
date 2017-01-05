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

## Liferay

alias aa='ant all'
alias aac='(cd ~/Liferay/liferay-plugins-ee/portlets/loop-portlet && aa && cd ~/Liferay/liferay-plugins-ee/themes/loop-theme && aa)'
alias csf='git ls-files -m | xargs check_sf'

# Functions

function gpp {
	[[ -z $1 ]] && 1='upstream'
	[[ -z $2 ]] && 2=$(git rev-parse --abbrev-ref HEAD)

	git pull "$1" "$2" && git push origin "$2"
}

function lsl {
	local src_dir="/Users/mike/Liferay/liferay-plugins-ee/portlets/loop-portlet/docroot/js/dist"
	local dst_dir="/Users/mike/Liferay/bundles-ee/tomcat-7.0.54/webapps/loop-portlet/js/dist"

	for file in "$src_dir"/*; do
		local filename=${file##*/}
		local dst="$dst_dir/$filename"

		[ -e "$dst" ] && rm "$dst"

		echo "Linking $filename"
		ln -F "$file" "$dst"
	done
}

function gw {
	local root_level=$(git rev-parse --show-toplevel 2>/dev/null)

	if [[ -n "$root_level" && -f "$root_level/gradlew" ]]; then
		root_level="$root_level/gradlew"
	else
		root_level=$(which gradle)
	fi

	"$root_level" $@
}
