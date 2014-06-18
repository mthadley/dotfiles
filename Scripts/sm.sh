#!/usr/bin/bash
#
# Setup second monitor
#
# Sleeping between commands seems to alleviate
# unpredictable window placement

CMDS=(
	ncmpcpp
	"yaourt -Qua"
	weechat-curses
	mumble
)

for CMD in "${CMDS[@]}"; do
	if [ $CMD = "mumble" ]; then
		mumble &
	else
		urxvt -e zsh -c "$CMD && zsh" &
	fi
	sleep 1
done

# Close Mumble dialog
sleep 1
bspc window focused -c

# Refocus montior
sleep 1
bspc monitor DVI-I-0 -f

# Readjust windows
sleep 1
bspc window focused -e right 0.35
sleep 1
bspc window focused -s right
