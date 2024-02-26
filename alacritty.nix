{ pkgs }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window = {
        padding = { x = 10; y = 10; };
        decorations = "Full";
        opacity = 0.9;
      };
      font = {
        size = 12.0;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };
      cursor = { style = "Beam"; };
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };
      colors = {
        primary = { background = "0x1b182c"; foreground = "0xcbe3e7"; };
        normal = {
          black = "0x100e23"; red = "0xff8080"; green = "0x95ffa4";
          yellow = "0xffe9aa"; blue = "0x91ddff"; magenta = "0xc991e1";
          cyan = "0xaaffe4"; white = "0xcbe3e7";
        };
        bright = {
          black = "0x565575"; red = "0xff5458"; green = "0x62d196";
          yellow = "0xffb378"; blue = "0x65b2ff"; magenta = "0x906cff";
          cyan = "0x63f2f1"; white = "0xa6b3cc";
        };
      };
    };
  };
}