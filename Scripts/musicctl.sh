#!/usr/bin/bash

FIFO=/home/mike/.config/pianobar/ctl

if [[ $(pgrep pianobar) -gt 0 ]]; then
	case $1 in
		next)
			echo 'n' > $FIFO
			;;
		pause)
			echo 'p' > $FIFO
			;;
		prev)
			echo '+' > $FIFO
			;;
		#info)
			
	esac
else
	case $1 in
		pause)
			$(ncmpcpp toggle)
			;;
		next)
			$(ncmpcpp next)
			;;
		prev)
			$(ncmpcpp prev)
			;;
		info)
			$(ncmpcpp --now-playing)
			;;
	esac
fi	
