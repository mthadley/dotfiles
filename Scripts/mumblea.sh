# Script to change mumble audio source
#
# Use "pacmd list-source-outputs" to find mumble ID (x)
# Use "pacmd list-sources" to find source device ID (y)
#
# pacmd move-source-output x y
#
# Good Idea to Adjust volume too: 0 = mute, 65536 = 100%
# In mumble, set bitrate to maximum and turn off all audio processing

LOGI=$(pacmd list-sources | grep -iB 1 "alsa_input.usb-Logitech" | grep index | sed 's/.*: //')
MUMBLE=$(pacmd list-source-outputs | grep -iB 15 Mumble | grep index | sed 's/.*: //')
SCHIIT=$(pacmd list-sources | grep -iB 1 Schiit | grep index | sed 's/.*: //')

case $1 in
	dev1)
		pacmd move-source-output $MUMBLE $LOGI
		pacmd set-source-output-volume $MUMBLE 90000
		;;
	dev2)
		pacmd move-source-output $MUMBLE $SCHIIT
		pacmd set-source-output-volume $MUMBLE 75214
		;;
esac
