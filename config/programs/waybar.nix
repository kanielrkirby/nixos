{ username, ... }:

{
  home-manager.users."${username}" = {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "left";
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ ];
          modules-right = [
            "pulseaudio"
            "network"
            "backlight"
            "battery"
            "clock"
            "tray"
            "custom/power"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            sort-by-name = false;
            active-only = false;
            all-outputs = true;
            format = "{icon}";
            format-icons = { default = ""; };
          };

          pulseaudio = {
            format = " {icon} ";
            format-muted = "󰖁";
            format-icons = [ "" "" "" ];
            tooltip = true;
            tooltip-format = "{volume}%";
          };

          network = {
            format-wifi = "󰤨 ";
            format-disconnected = "󰤭 ";
            format-ethernet = "󰈀 ";
            tooltip = true;
            tooltip-format = "{signalStrength}%";
          };

          backlight = {
            device = "intel_backlight";
            format = "{icon}";
            format-icons = [ "" "" "" "" "" "" "" "" "" ];
            tooltip = true;
            tooltip-format = "{percent}%";
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-charging = "󰂄";
            format-plugged = "󰂄";
            format-icons = [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            tooltip = true;
            tooltip-format = "{capacity}%";
          };

          clock = {
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
            format-alt = ''
               {:%d
               %m
              %Y}'';
            format = ''
              {:%H
              %M}'';
          };

          tray = {
            icon-size = 18;
            spacing = 20;
          };
        };
      };
    };
  };

  security.pam.services.swaylock = { };
}
