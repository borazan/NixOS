#gets imported into hyprland.nix > home.nix
{ pkgs, ... }:

{

  home.packages = [ pkgs.inter ];

  services.playerctld.enable = true;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"] ;} );
    settings = {
      mainBar = {
        margin = "0";
        layer = "top";
        modules-left = [ "custom/nix" "wlr/workspaces" "mpris" ];
        modules-center = [ "wlr/taskbar"];
        modules-right = [ "pulseaudio" "network#interface" "network#speed" "cpu" "temperature" "clock" "tray" ];

        persistent_workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
        };

        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            "1" = "<span foreground=\"#A1EFD3\"></span>";
            "2" = "<span foreground=\"#FFE6B3\">󰈹</span>";
            "3" = "<span foreground=\"#91DDFF\">󰒱</span>";
            "4" = "<span foreground=\"#D4BFFF\">󰧑</span>";
          };
        };

        mpris = {
          format = "{status_icon}<span weight='bold'>{artist}</span> | {title}";
          status-icons = {
            playing = "<span foreground='#A1EFD3'>󰎈</span> ";
            paused =  "<span foreground='#FFE6B3'>󰏤</span> ";
            stopped = "<span foreground='#F48FB1'>󰓛</span> ";
          };
        };

        "custom/nix" = {
          format = "󱄅 ";
        };

        "wlr/taskbar" = {
          on-click = "activate";
        };

        pulseaudio = {
          format = "<span foreground='#F48FB1'>󰓃</span> {volume}%";
        };

        "network#interface" = {
          format-ethernet = "<span foreground='#91DDFF'>󰣶 </span> {ifname}";
          format-wifi = "<span foreground='#91DDFF'>󰖩 </span>{ifname}";
          tooltip = true;
          tooltip-format = "{ipaddr}";
        };

        "network#speed" = {
          format = "<span foreground='#78A8FF'>⇡</span>{bandwidthUpBits} <span foreground='#78A8FF'>⇣</span>{bandwidthDownBits}";
        };

        cpu = {
          format = "<span foreground='#D4BFFF'>  </span>{usage}% <span foreground='#D4BFFF'>󱐌 </span>{avg_frequency}";
        };

        temperature = {
          format = "<span foreground='#FFE6B3'>{icon} </span>{temperatureC} °C";
          format-icons = [ "" "" "" "󰈸"];
        };

        clock = {
          format = "<span foreground='#A1EFD3'>  </span>{:%H:%M}";
          format-alt = "<span foreground='#A1EFD3'󰃭  </span>{:%Y-%m-%d}";
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        min-height: 0;
        color: #CBE3E7;
      }

      window#waybar {
        border-bottom: solid 2px #2D2B40;
        font-family: 'Inter', 'RobotoMono Nerd Font';
        font-size: 14px;
      }

      tooltip {
        background-color: #2D2B40;
        color: #CBE3E7;
      }

      #custom-nix {
        color: #91DDFF;
        padding: 2px 8px;
      }

      #workspaces button {
        padding: 2px 8px;
        margin: 0 8px 0 0;
      }

      #workspaces button.active {
        background-color: #2D2B40;
      }

      #taskbar button.active {
        background-color: #2D2B40;
      }

      .modules-right * {
        padding: 0 8px;
        margin: 0 0 0 4px;
      }

      #mpris {
        background-color: #2D2B40;
        padding: 0 8px;
        color: #8A889D;
      }

      #tray {
        background-color: #2D2B40;
        padding: 0 8px 0 8px;
      }
      
      #tray * {
        padding: 0;
        margin: 0;
      }
    '';
  };
}
