{ pkgs, ... }: 

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

      settings = {
        # ENV
        monitor=[
          "eDP-1,2400x1600,0x0,1.6"
          ",preferred,auto,1"
        ];
        env = [
          "XCURSOR_SIZE,20"
        ];
        
        # STARTUP
        exec-once = [
          "xcalib /usr/share/color/icc/BOE_CQ_______NE135FBM_N41_01.icm"
          "hyprpm enable hyprbars"
          "eww open bar0"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "systemctl --user import-environment"
        ];
        
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
        };
        
        device.logitech-mx-master-3-for-mac-1 = {
          sensitivity = -0.2;
        };
        
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
          blur = {
            enabled = false;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
          drop_shadow = false;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };
        
        animations = {
          enabled = false;
        };
        
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        
        gestures = {
          workspace_swipe = true;
        };
        
        misc = {
          force_default_wallpaper = false;
          disable_hyprland_logo = true;
        };

      };
      extraConfig = ''
      # BINDS

      $mod1 = SUPER
      
      # Global / General
      bind = $mod1, space, exec, fuzzel
      bind = $mod1, P, togglefloating,
      bind = $mod1+SHIFT, P, togglesplit,
      binde = $mod1, Q, killactive
      
      # Fn / Function Keys
      bindelt = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+ -l 1.0
      bindelt = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%- -l 1.0
      bindelt = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle
      bindelt = $mod1, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+
      bindelt = $mod1, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-
      bindelt = , XF86MonBrightnessUp, exec, brightnessctl set +5%
      bindelt = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
      bindt = , Print, exec, grim -g "$(slurp)
      bindt = $mod1, Print, exec, grim -g "$(slurp)
      bindelt = , XF86AudioPlay, exec, playerctl play-pause
      bindelt = , XF86AudioNext, exec, playerctl position 5+
      bindelt = , XF86AudioPrev, exec, playerctl position 5-
      
      # Pass / 2FA
      bind = $mod1, Period, exec, hyprctl exec 
      bind = $mod1+CTRL, Period, exec, sys secure 2fa insert
      bind = $mod1+SHIFT, Period, togglespecialworkspace, 2fa
      bind = $mod1, Comma, exec, sys secure pass show
      bind = $mod1+CTRL, Comma, exec, sys secure pass insert
      bind = $mod1+SHIFT, Comma, togglespecialworkspace, pass
      
      # Vim-like window movement
      bind = $mod1, H, movewindow, l
      bind = $mod1, L, movewindow, r
      bind = $mod1, K, movewindow, u
      bind = $mod1, J, movewindow, d
      bind = $mod1+SHIFT_L, H, movefocus, l
      bind = $mod1+SHIFT_L, L, movefocus, r
      bind = $mod1+SHIFT_L, K, movefocus, u
      bind = $mod1+SHIFT_L, J, movefocus, d
      
      bindirtl = SUPER, SUPER_L, submap, reset
      
      # Primary Submap
      bindl = $mod1, semicolon, submap, primary
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
      bindil = $mod1, T, exec, alacritty
      bindil = $mod1, E, exec, sys file
      bindil = $mod1, V, exec, virt-manager
      bindil = $mod1, W, exec, brave
      bindil = $mod1, B, exec, alacritty -e btop
      bindil = $mod1, Z, exec, signal-desktop --ozone-platform=wayland
      bindil = $mod1, C, exec, code
      bindil = $mod1, N, exec, alacritty -e nvim ~
      bindil = $mod1, M, exec, thunderbird
      bindil = $mod1, V, exec, virt-manager
      bindil = $mod1, D, exec, dbeaver
      bindil = $mod1, L, exec, localsend
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
      bind = $mod1, 1, workspace, 1
      bind = $mod1, 2, workspace, 2
      bind = $mod1, 3, workspace, 3
      bind = $mod1, 4, workspace, 4
      bind = $mod1, 5, workspace, 5
      bind = $mod1, 6, workspace, 6
      bind = $mod1, 7, workspace, 7
      bind = $mod1, 8, workspace, 8
      bind = $mod1, 9, workspace, 9
      bind = $mod1, 0, workspace, 10
      bind = $mod1 SHIFT, 1, movetoworkspace, 1
      bind = $mod1 SHIFT, 2, movetoworkspace, 2
      bind = $mod1 SHIFT, 3, movetoworkspace, 3
      bind = $mod1 SHIFT, 4, movetoworkspace, 4
      bind = $mod1 SHIFT, 5, movetoworkspace, 5
      bind = $mod1 SHIFT, 6, movetoworkspace, 6
      bind = $mod1 SHIFT, 7, movetoworkspace, 7
      bind = $mod1 SHIFT, 8, movetoworkspace, 8
      bind = $mod1 SHIFT, 9, movetoworkspace, 9
      bind = $mod1 SHIFT, 0, movetoworkspace, 10
      
      # Special Workspaces
      bind = $mod1, A, togglespecialworkspace, scratchpad-1
      bind = $mod1, S, togglespecialworkspace, scratchpad-2
      bind = $mod1, D, togglespecialworkspace, scratchpad-3
      bind = $mod1, F, togglespecialworkspace, scratchpad-4
      bind = $mod1 SHIFT, A, movetoworkspace, special:scratchpad-1
      bind = $mod1 SHIFT, S, movetoworkspace, special:scratchpad-2
      bind = $mod1 SHIFT, D, movetoworkspace, special:scratchpad-3
      bind = $mod1 SHIFT, F, movetoworkspace, special:scratchpad-4
      bind = $mod1, N, exec, alacritty -e nvim /home/mx/Documents/
      
      # SWITCH
      bindl= , switch:Lid Switch, exec, sys lock
      '';
    };
    #plugins = [
    #  #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    #];
  };
}
