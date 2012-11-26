#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Server terminals
urxvtd -q -f -o

# Black terminal
xrdb -merge .Xresources &

# ABNT2 keyboard
setxkbmap us intl

# No capslock
xmodmap ~/.Xmodmap

exec ssh-agent awesome
