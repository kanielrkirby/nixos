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
              format-icons =
                [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
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
        style = ''
          /*
          *
          * Catppuccin Mocha palette
          * Maintainer: rubyowo
          *
          */

          @define-color base   #1e1e2e;
          @define-color mantle #181825;
          @define-color crust  #11111b;

          @define-color text     #cdd6f4;
          @define-color subtext0 #a6adc8;
          @define-color subtext1 #bac2de;

          @define-color surface0 #313244;
          @define-color surface1 #45475a;
          @define-color surface2 #585b70;

          @define-color overlay0 #6c7086;
          @define-color overlay1 #7f849c;
          @define-color overlay2 #9399b2;

          @define-color blue      #89b4fa;
          @define-color lavender  #b4befe;
          @define-color sapphire  #74c7ec;
          @define-color sky       #89dceb;
          @define-color teal      #94e2d5;
          @define-color green     #a6e3a1;
          @define-color yellow    #f9e2af;
          @define-color peach     #fab387;
          @define-color maroon    #eba0ac;
          @define-color red       #f38ba8;
          @define-color mauve     #cba6f7;
          @define-color pink      #f5c2e7;
          @define-color flamingo  #f2cdcd;
          @define-color rosewater #f5e0dc;

          * {
            font-family: MonaspiceXe Nerd Font Regular;
            font-size: 16px;
            min-height: 0;
          }

          window#waybar {
            background: transparent;
          }

          #workspaces {
            border-radius: 1rem;
            background-color: @surface0;
            margin-top: 1rem;
            margin: 7px 3px 0px 7px;
          }

          #workspaces button {
            color: @pink;
            border-radius: 1rem;
            padding-left: 6px;
            margin: 5px 0;
            box-shadow: inset 0 -3px transparent;
            transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
            background-color: transparent;
          }

          #workspaces button.active {
            color: @flamingo;
            border-radius: 1rem;
          }

          #workspaces button:hover {
            color: @rosewater;
            border-radius: 1rem;
          }

          #tray,
          #network,
          #backlight,
          #clock,
          #battery,
          #pulseaudio,
          #custom-lock,
          #custom-power {
            background-color: @surface0;
            margin: 7px 3px 0px 7px;
            padding: 10px 5px 10px 5px;
            border-radius: 1rem;
          }

          #clock {
            color: @lavender;
          }

          #battery {
            color: @green;
          }

          #battery.charging {
            color: @green;
          }

          #battery.warning:not(.charging) {
            color: @red;
          }

          #network {
              color: @flamingo;
          }

          #backlight {
            color: @yellow;
          }

          #pulseaudio {
            color: @pink;
          }

          #pulseaudio.muted {
              color: @red;
          }

          #custom-power {
              border-radius: 1rem;
              color: @red;
              margin-bottom: 1rem;
          }

          #tray {
            border-radius: 1rem;
          }

          tooltip {
              background: @base;
              border: 1px solid @pink;
          }

          tooltip label {
              color: @text;
          }
        '';
      };
  };
}
