# My NixOS Setup

This repository uses NixOS along with flakes and home-manager for managing various system components. It's meant for a single user environment that is easily reproducible.

## Various components

I originally installed NixOS using the graphical installer to install KDE Plasma but then decided to switch over to a tiling window manager (Hyprland). However, it is still possible to easily switch between the two by changing the *imports* part of *configuration.nix* and *home.nix*.

### *configuration.nix*
Main configuration file for the nix system, all system wide packages are installed and managed here as well as shell aliases, bluetooth settings, audio management.
### *home.nix*
Main homemanager configuration file, can handle both the KDE Plasma version as well as Hyprland.
The import structure is different for the two variants:
1. Hyprland
+ dunst.nix & waybar.nix > hyprland.nix > home.nix
2. KDE
+ kde.nix > home.nix
### *profiles*
This folder holds the two variants, KDE and Hyprland and their various components.
### *hyprland-configuration.nix*
This can be seen as an extension of *configuration.nix* which holds specific settings for running Hyprland.
### *hyprland.nix*
Holds the nixified version of the hyprland.config file. The configuration holds various keybinds for switching between workspaces, moving windows around etc. 

Generates the config file from the defined settings on startup. For dynamically editing the hyprland setup without having to rebuild the entire system every time, it's better to mv the actual hyprland.config file, create a new file and symlink it to it's direction since NixOS apparently mounts the configurations files as read-only systems, which makes it impossible to edit directly.
### *waybar.nix*
Waybar is the bar responsible for displaying a plethora of information. It displays workspaces with custom logos, a media indicator, various windows open and a centralized hub on the right for audio, wifi, cpu usage, temps, clock etc.
### *dunst.nix*
Dunst is the notification daemon that's used for sending notifications with a pop-up, it's also used for a custom volume display that's managed by volume-control.sh.
### *start.sh*
This script runs on startup, setting a wallpaper with *swww*, enabling the networkmanager applet, starting waybar and dunst.
#### *rebuild.sh*
simple script that can be run in any directory to temporarily switch to the *~/nixos-config/* directory, displaying a git diff, running nixos-rebuild and then switching back with popd to the original directory.
#### *upgrade.sh*
similar to *rebuild.sh* but for upgrading the system components.
