#!/usr/bin/bash
# Backup configs to a separate folder

PWD=$(pwd)
FILES=( 
	.xinitrc 
	.Xresources
	.conkyrc_bar
	.weechat/weechat.conf
	.ncmpcpp/config
	Scripts
	bar/config.h
	.mpd/mpd.conf
	.newsbeuter/config
	.newsbeuter/urls
	.tmux.conf
	.config/homepage
	.config/bspwm
	.config/sxhkd/
	.vimrc
	.vim/colors
)
DEST=~/configs-git

cd ~ 

echo "Backing up dot files..."
for FILE in ${FILES[*]}; do
	cp -vLR --parents $FILE $DEST 
done
echo "...Done"

cd $PWD
