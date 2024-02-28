#gets imported into hyprland.nix > home.nix
{...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#2D2B40";
        width = 200;
        height = 80;
        offset = "30x30";
        padding = 8;
        horizontal_padding = 8;
        icon_corner_radius = 8;
        corner_radius = 16;
        separator_color = "#585273";
      };

      urgency_low = {
        background = "#2D2B40";
      };

      urgency_normal = {
        background = "#2D2B40";
      };

      urgency_high = {
        background = "#2D2B40";
      };

      discord = {
        appname = "Discord";
        urgency = "low";
      };
    };
  };
}
