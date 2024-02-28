{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./profiles/hyprland/hyprland-configuration.nix #comment out if using KDE instead of hyprland
    #./profiles/kde/kde.nix #comment out if using hyprland instead of KDE
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #AMD GPU
  boot.initrd.kernelModules = ["amdgpu"];
  hardware.opengl = {
    # Mesa
    enable = true;
    # Vulkan
    driSupport = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.borazan = {
    isNormalUser = true;
    description = "Bora";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      #user specific packages go here
    ];
  };

  home-manager = {
    #also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      borazan.imports = [./home.nix];
    };
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    vimPlugins.LazyVim
    obsidian
    google-chrome
    discord
    git
    vscode
    wget #like curl
    btop
    nnn
    unzip
    zsh
    sublime #might replace with newer version, ugly
    uutils-coreutils-noprefix #installed in case other utilities are needed
    nixpkgs-fmt #used in vscode nix code formatter
    alacritty #terminal emulator
    alacritty-theme #themes for alacritty
    playerctl #used by waybar
    nerdfonts
    alejandra #used in rebuild.sh script for formatting rebuild output to terminal
    pulseaudio #used for keyboard volume control with pactl command
    wev #command-line utility for showing keycodes on keypress
  ];

  fonts.packages = with pkgs; [nerdfonts];

  # fonts.packages = with pkgs; [
  #   (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; }) #alacritty.nix uses FiraCode
  # ];

  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;
  programs.ssh.startAgent = true;
  users.defaultUserShell = pkgs.zsh;
  services.getty.autologinUser = "borazan";

  environment.shellAliases = {
    rebuild = "bash rebuild.sh";
    upgrade = "bash upgrade.sh";
    nixify = "bash /home/borazan/nixos-config/nixify.sh";
    nvimflake = "nix run github:jordanisaacs/neovim-flake#nix";
  };

  system.stateVersion = "23.11"; # don't change
}
