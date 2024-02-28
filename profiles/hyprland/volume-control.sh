#!/bin/bash

# Path to the notification icon
ICON_PATH="/home/borazan/nixos-config/profiles/hyprland/speaker-up.svg" # Adjust the icon path as necessary

# Determine action based on argument
case "$1" in
  up)
    /run/current-system/sw/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%
    ;;
  down)
    /run/current-system/sw/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
    ;;
  mute)
    /run/current-system/sw/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Usage: $0 {up|down|mute}"
    exit 1
    ;;
esac

# Get the mute status
MUTED=$(/run/current-system/sw/bin/pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(?<=Mute: )\w+')

# Get the current volume level
VOLUME=$(/run/current-system/sw/bin/pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)

# Prepare the notification
if [ "$MUTED" = "yes" ]; then
  NOTIFY_TEXT="Muted"
  ICON_PATH="/home/borazan/nixos-config/profiles/hyprland/speaker-off.svg" # Adjust for muted icon
else
  NOTIFY_TEXT="Volume: $VOLUME"
fi

# Send the notification
dunstify -a "changeVolume" -u low -i "$ICON_PATH" -h int:value:"${VOLUME%\%}" "$NOTIFY_TEXT"
