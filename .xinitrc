#!/bin/sh
# Mike's xinitrc
HOME=/home/mike

# PAaudio server
pulseaudio --start

# Background
$HOME/.fehbg

# Music
pulseaudio --start
mpd $HOME/.mpd/mpd.conf

# Load terminal colors
xrdb $HOME/.Xresources

dropboxd &
curl -s ifconfig.me > $HOME/Dropbox/ip.txt

xset +fp /usr/share/fonts/local
xset fp rehash &

WM='dwm'
FG='#696969'
BG='#141414'
compton -cGb --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc -fD 5

WM='bspwm'
case $WM in 
	dwm)
		FONT="-*-Terminess Powerline-medium-r-*-*-14-*-*-*-*-*-*-*"
		(sleep 4; conky -c $HOME/.conkyrc_dzen2 | dzen2 -xs 1 -x 200 -e - -h '16' -ta r -fg $FG -bg $BG -fn "$FONT") &
		exec dwm
		;;
	bspwm)
		sxhkd &
		exec bspwm -c $HOME/.config/bspwm/bspwmrc
		;;
esac
