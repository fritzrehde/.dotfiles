#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

setxkbmap -layout us -variant altgr-intl -option caps:escape
xset r rate 200 25

sxhkd &
clipmenud &
dunst &
redshift &
unclutter --start-hidden --timeout 1 &
feh --no-fehbg --bg-scale ~/.wallpapers/macos_mojave_night.jpg
exec bspwm
