{ inputs, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    libinput.enable = true;
    videoDrivers = [ "modesetting" ];

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "where_is_my_sddm_theme";
      };
    };
  };

  xdg.portal = {
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  home-manager = {
    users.mx.home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    users.mx.wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        # ENV
        monitor = [ ",preferred,auto,1.6" ];
        env = [ ];

        workspace = [
          "1,persistent:true"
          "2,persistent:true"
          "3,persistent:true"
          "4,persistent:true"
          "5,persistent:true"
          "6,persistent:true"
          "7,persistent:true"
          "8,persistent:true"
          "9,persistent:true"
          "10,persistent:true"
        ];

        exec-once = [
          #"hyprpm enable hyprbars"
          "systemctl --user import-environment"
          "waybar"
#          "hyprpaper"
#          "wallpaper"
        ];

        #debug.overlay = true;

        # VARS
        input = {
          kb_layout = "us";
          repeat_rate = 100;
          repeat_delay = 200;
          follow_mouse = true;
          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.25;
            disable_while_typing = true;
          };
          sensitivity = 0.2;
          kb_options = [ ];
        };

        device.logitech-mx-master-3-for-mac-1 = { sensitivity = -0.2; };

        general = {
          gaps_in = 2;
          gaps_out = 2;
          border_size = 1;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 3;
          blur.enabled = false;
          drop_shadow = false;
          dim_inactive = false;
        };

        animations.enabled = false;

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        gestures = { workspace_swipe = true; };

        misc = {
          force_default_wallpaper = false;
          disable_hyprland_logo = true;
          background_color = "0x000000";
          vfr = false;
        };

      };
      plugins = [
        # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      ];
      extraConfig = ''
        # BINDS

        # Global / General
        bind = SUPER, space, exec, fuzzel
        bind = SUPER, P, togglefloating,
        bind = SUPER+SHIFT, P, togglesplit,
        binde = SUPER, Q, killactive

        # Fn / Function Keys
        bindelt = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+ -l 1.0
        bindelt = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%- -l 1.0
        bindelt = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle
        bindelt = SUPER, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+
        bindelt = SUPER, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-
        bindelt = , XF86MonBrightnessUp, exec, brightnessctl set +5%
        bindelt = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
        bindt = , Print, exec, grim -g "$(slurp)
        bindt = SUPER, Print, exec, grim -g "$(slurp)
        bindelt = , XF86AudioPlay, exec, playerctl play-pause
        bindelt = , XF86AudioNext, exec, playerctl position 5+
        bindelt = , XF86AudioPrev, exec, playerctl position 5-

        # Pass / 2FA
        bind = SUPER, Period, exec, hyprctl exec
        bind = SUPER+CTRL, Period, exec, sys secure 2fa insert
        bind = SUPER+SHIFT, Period, togglespecialworkspace, 2fa
        bind = SUPER, Comma, exec, sys secure pass show
        bind = SUPER+CTRL, Comma, exec, sys secure pass insert
        bind = SUPER+SHIFT, Comma, togglespecialworkspace, pass

        # Vim-like window movement
        bind = SUPER, H, movewindow, l
        bind = SUPER, L, movewindow, r
        bind = SUPER, K, movewindow, u
        bind = SUPER, J, movewindow, d
        bind = SUPER+SHIFT_L, H, movefocus, l
        bind = SUPER+SHIFT_L, L, movefocus, r
        bind = SUPER+SHIFT_L, K, movefocus, u
        bind = SUPER+SHIFT_L, J, movefocus, d

        bindirtl = SUPER, SUPER_L, submap, reset

        # Primary Submap
        bindl = SUPER, semicolon, submap, primary
        submap = primary
        bindil = , N, submap, n
        bindil = , M, submap, mullvad
        bindil = , F, submap, fanduty
        bindil = , S, submap, syncthing
        bindil = , B, submap, bluetooth
        bindil = , O, submap, browser
        bindil = , E, submap, system
        bindil = , L, submap, launch
        bindil = , V, submap, vm
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Launch
        submap = launch
        bindil = SUPER, T, exec, alacritty
        bindil = SUPER, R, exec, kitty
        bindil = SUPER, E, exec, sys file
        bindil = SUPER, V, exec, virt-manager
        bindil = SUPER, W, exec, brave
        bindil = SUPER, B, exec, alacritty -e btop
        bindil = SUPER, Z, exec, signal-desktop --ozone-platform=wayland
        bindil = SUPER, C, exec, code
        bindil = SUPER, N, exec, alacritty -e nvim ~
        bindil = SUPER, M, exec, thunderbird
        bindil = SUPER, V, exec, virt-manager
        bindil = SUPER, D, exec, dbeaver
        bindil = SUPER, L, exec, localsend
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Browser Mode
        submap = browser
        bindil = , Y, exec, brave https://youtube.com
        bindil = , G, exec, brave https://github.com/kanielrkirby
        bindil = , T, exec, brave https://trello.com/b/m5QBnONR
        bindil = , D, exec, brave https://discord.com/app
        bindil = , B, exec, brave https://libgen.is
        bindil = , C, exec, brave https://chat.openai.com
        bindil = , A, exec, brave https://amazon.com
        bindil = , L, exec, brave https://linkedin.com
        bindil = , N, exec, brave https://netlify.com
        bindil = , R, exec, brave https://reddit.com
        bindil = , P, exec, brave https://pexels.com
        bindil = , F, exec, brave https://my.freshbooks.com
        bindil = , M, exec, brave https://monkeytype.com
        bindil = , V, exec, brave https://vscode.dev
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # System Mode
        submap = system
        bindil = , R, exec, reboot
        bindil = , D, exec, shutdown
        bindil = , L, exec, swaylock
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Fan Duty Mode
        submap = fanduty
        bindil = , A, exec, ectool autofanctrl & notify-send "Fan: Auto"
        bindil = , grave, exec, ectool fanduty 0 & notify-send "Fan: Off (Dangerous)"
        bindil = , 1, exec, ectool fanduty 10 & notify-send "Fan: 10"
        bindil = , 2, exec, ectool fanduty 20 & notify-send "Fan: 20"
        bindil = , 3, exec, ectool fanduty 30 & notify-send "Fan: 30"
        bindil = , 4, exec, ectool fanduty 40 & notify-send "Fan: 40"
        bindil = , 5, exec, ectool fanduty 50 & notify-send "Fan: 50"
        bindil = , 6, exec, ectool fanduty 60 & notify-send "Fan: 60"
        bindil = , 7, exec, ectool fanduty 70 & notify-send "Fan: 70"
        bindil = , 8, exec, ectool fanduty 80 & notify-send "Fan: 80"
        bindil = , 9, exec, ectool fanduty 90 & notify-send "Fan: 90"
        bindil = , 0, exec, ectool fanduty 100 & notify-send "Fan: Max"
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Mullvad Mode
        submap = mullvad
        bindil = , R, exec, mullvad reconnect --wait; if [[ "$(mullvad status)" = "Disconnected" ]]; then mullvad connect --wait; fi; notify-send "$(mullvad status)"
        bindil = , C, exec, if [[ "$(mullvad status)" != "Disconnected" ]]; then notify-send "Already Connected"; else mullvad connect --wait; notify-send "$(mullvad status)"; fi
        bindil = , D, exec, mullvad disconnect --wait; notify-send "$(mullvad status)"
        bindil = , O, exec, notify-send "$(mullvad status)"
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap=reset

        # Nightlight / Notification Mode
        submap = n
        bindil = , A, exec, hyprshade auto & notify-send "Nightlight: Auto"
        bindil = , 0, exec, hyprshade off & notify-send "Nightlight: Off"
        bindil = , 1, exec, hyprshade on blue-light-filter & notify-send "Nightlight: On"
        bindil = , D, exec, makoctl dismiss -a
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Syncthing Mode
        # submap = syncthing
        # bindil = , R, exec, sys syncthing restart
        # bindil = , D, exec, sys syncthing down
        # bindil = , U, exec, sys syncthing up
        # bindil = , escape, submap, reset
        # bindirtl = SUPER, SUPER_L, submap, reset
        # submap = reset

        # Bluetooth Mode
        submap = bluetooth
        bindil = , C, submap, bluetooth_connect
        bindil = , D, submap, bluetooth_disconnect
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Bluetooth Connect Mode
        submap = bluetooth_connect
        bindil = , H, exec, bluetoothctl connect "" & notify-send "Bluetooth: Headphones Connected"
        bindil = , M, exec, bluetoothctl connect "" & notify-send "Bluetooth: Mouse Connected"
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Bluetooth Disconnect Mode
        submap = bluetooth_disconnect
        bindil = , H, exec, bluetoothctl disconnect "" & notify-send "Bluetooth: Headphones Disconnected"
        bindil = , M, exec, bluetoothctl disconnect "" & notify-send "Bluetooth: Mouse Disconnected"
        bindil = , escape, submap, reset
        bindirtl = SUPER, SUPER_L, submap, reset
        submap = reset

        # Workspaces
        bind = SUPER, 1, workspace, 1
        bind = SUPER, 2, workspace, 2
        bind = SUPER, 3, workspace, 3
        bind = SUPER, 4, workspace, 4
        bind = SUPER, 5, workspace, 5
        bind = SUPER, 6, workspace, 6
        bind = SUPER, 7, workspace, 7
        bind = SUPER, 8, workspace, 8
        bind = SUPER, 9, workspace, 9
        bind = SUPER, 0, workspace, 10
        bind = SUPER SHIFT, 1, movetoworkspace, 1
        bind = SUPER SHIFT, 2, movetoworkspace, 2
        bind = SUPER SHIFT, 3, movetoworkspace, 3
        bind = SUPER SHIFT, 4, movetoworkspace, 4
        bind = SUPER SHIFT, 5, movetoworkspace, 5
        bind = SUPER SHIFT, 6, movetoworkspace, 6
        bind = SUPER SHIFT, 7, movetoworkspace, 7
        bind = SUPER SHIFT, 8, movetoworkspace, 8
        bind = SUPER SHIFT, 9, movetoworkspace, 9
        bind = SUPER SHIFT, 0, movetoworkspace, 10

        # Special Workspaces
        bind = SUPER, A, togglespecialworkspace, scratchpad-1
        bind = SUPER, S, togglespecialworkspace, scratchpad-2
        bind = SUPER, D, togglespecialworkspace, scratchpad-3
        bind = SUPER, F, togglespecialworkspace, scratchpad-4
        bind = SUPER SHIFT, A, movetoworkspace, special:scratchpad-1
        bind = SUPER SHIFT, S, movetoworkspace, special:scratchpad-2
        bind = SUPER SHIFT, D, movetoworkspace, special:scratchpad-3
        bind = SUPER SHIFT, F, movetoworkspace, special:scratchpad-4
        bind = SUPER, N, exec, alacritty -e nvim /home/mx/Documents/

        # SWITCH
        bindl= , switch:Lid Switch, exec, sys lock
      '';
    };
  };
}

