#!/usr/bin/env bash

# initializing wallpaper daemon
sww init &
#setting wallpaper
swww img ~/Downloads/susan-wilkinson-R4mGCTTVjuo-unsplash.jpg

nm-applet --indicator &

#the bar 
waybar &

# mako notification daemon
dunst