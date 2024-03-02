#!/bin/bash
swayidle -w \
timeout 300 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' \
timeout 500 'systemctl suspend' \