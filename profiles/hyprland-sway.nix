{ config, lib, pkgs, ... }:
let
  # Override the waybar package before adding it to systemPackages
  #needed to display workspaces correctly on hyprland
  waybarCustom = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });
in
{
  #followed this to generate: https://www.youtube.com/watch?v=61wGzIv12Ds
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    waybarCustom
    mako #notification daemon
    libnotify #needed for mako
    swww #wallpaper daemon
    kitty #hyprland's default terminal (remove later)
    rofi-wayland #window switcher/launcher

  ];

  #desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

}
