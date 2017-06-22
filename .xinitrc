#!/usr/env/bin bash

xrandr
xrandr --output=VGA-1 --mode 2560-1440 --rate 59.97

exec i3

xrdb -load ~/.Xresources
