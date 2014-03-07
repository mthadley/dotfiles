#!/usr/bin/bash
# Display appropriate message, for conky.

sudo pacman -Sy > /dev/null
PACKAGES=`pacman -Qu | wc -l`

case $PACKAGES in 
	0)
		echo -n "No New Packages"
		;;
	1)
		echo -n "1 New Package"
		;;
	*)
		echo -n "$PACKAGES New Packages"
		;;	
esac
