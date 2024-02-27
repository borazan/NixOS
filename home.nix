{ config, pkgs, ... }:

{
   imports = [
    (import ./alacritty.nix { inherit pkgs; })
    (import ./profiles/hyprland/hyprland.nix { inherit pkgs; }) #comment out if using KDE instead of hyprland
    # Import other modules here
  ];
  home.username = "borazan";
  home.homeDirectory = "/home/borazan";

  home.stateVersion = "23.11"; # don't change

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
        # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
      thefuck
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck"];
      theme = "robbyrussell";
    };
    # Use `interactiveShellInit` to define shell functions for interactive sessions
    initExtra = ''
      push() {
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/github
        git push
      }
    '';
  };

  programs.git = {
    enable = true;
    userName = "borazan";
    userEmail = "boratuncel@gmail.com";
    aliases = {
      gitadd = "!git add . && git status";
      pu = "push";
      co = "checkout";
    };
  };

  #used for github ssh
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes"; # Optionally, automatically add SSH keys to the agent
  };
  services.ssh-agent.enable = true;

  programs.zsh.prezto.ssh = {
    identities = [ "github "];
  };
}
