{ config, lib, pkgs, ...}:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "borazan";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
}