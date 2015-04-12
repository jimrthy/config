#!/bin/sh
# Mostly taken from:
# https://wiki.archlinux.org/index.php/Xinitrc

# Run init files
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [-x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -layout dvorak

# update x resources db
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# starts screensaver daemon
xscreensaver -no-splash &

# sets the cursor icon
xsetroot -curson_name left_ptr &

# Well, I'd want to do this if my keyboard hadn't already moved capslock:
# (of course, that also implies *writing* .Xmodmap)
xmodmap ~/.Xmodmap

# X wants to swap my monitors' location. I need to fix that.
#xrandr --output DVI-D-0 --left-of DVI-I-1

# Pick a window manager:
case $1 in
  xfce) exec startxfce4;;
  xmonad) exec xmonad;;
  awesome);;
  *) exec awesome;;
esac

