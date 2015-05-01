#!/bin/sh

# PA server
pulseaudio --start

# Load terminal colors
# xrdb $HOME/.Xresources

compton -cGb --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc -fD 5

exec i3
