#!/usr/bin/env bash

# initializing wallpaper daemon
sww init &
#setting wallpaper
#sww img ~/Wallpapers/gruvbox-mountain-village.png #wallpaper goes here

nm-applet --indicator &

#the bar 
waybar &

# mako notification daemon
dunst