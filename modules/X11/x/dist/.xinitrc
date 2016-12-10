#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Black terminal
xrdb -merge .Xresources &

# colemak keyboard
setxkbmap -geometry kinesis -layout us -variant colemak

# No capslock
xmodmap ~/.Xmodmap

# Removing tap
synclient TapButton1=0

# GPG
test -x /usr/bin/gpg-agent && test -z "${GPG_AGENT_INFO}" && eval $(/usr/bin/gpg-agent --daemon --max-cache-ttl 28800 --default-cache-ttl 28800 --quiet)

exec ssh-agent startxfce4
#exec ssh-agent i3
#exec ssh-agent /home/pothix/.config/i3/sway-colemak
#exec ssh-agent gnome-session
#exec ssh-agent awesome
