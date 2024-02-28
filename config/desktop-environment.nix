{ inputs, pkgs, ... }: 

{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "where_is_my_sddm_theme";
    };
  };

  home-manager.users.mx.home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  home-manager.users.mx.gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
  
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  
    font = {
      name = "Sans";
      size = 11;
    };
  };

  home-manager.users.mx.wayland.windowManager.hyprland = {
    enable = true;
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
        # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
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
    bindelt = , XF86AudioMute, exec, sys volume mute
    bindelt = $mod1, XF86AudioRaiseVolume, exec, sys volume up --bypass
    bindelt = $mod1, XF86AudioLowerVolume, exec, sys volume down --bypass
    bindelt = , XF86MonBrightnessUp, exec, sys brightness up
    bindelt = , XF86MonBrightnessDown, exec, sys brightness down
    bindt = , Print, exec, sys screenshot
    bindt = $mod1, Print, exec, sys screenshot select
    bindelt = , XF86AudioPlay, exec, sys player toggle
    bindelt = , XF86AudioNext, exec, sys player forward
    bindelt = , XF86AudioPrev, exec, sys player backward
    
    # Pass / 2FA
    bind = $mod1, Period, exec, sys secure 2fa show
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
    bindil = $mod1, T, exec, hyprctl dispatch submap reset & alacritty
    bindil = $mod1, E, exec, hyprctl dispatch submap reset & sys file
    bindil = $mod1, V, exec, hyprctl dispatch submap reset & virt-manager
    bindil = $mod1, W, exec, hyprctl dispatch submap reset & brave
    bindil = $mod1, B, exec, hyprctl dispatch submap reset & alacritty -e btop
    bindil = $mod1, Z, exec, hyprctl dispatch submap reset & signal-desktop --ozone-platform=wayland
    bindil = $mod1, C, exec, hyprctl dispatch submap reset & code
    bindil = $mod1, N, exec, hyprctl dispatch submap reset & alacritty -e nvim ~
    bindil = $mod1, M, exec, hyprctl dispatch submap reset & thunderbird
    bindil = $mod1, V, exec, hyprctl dispatch submap reset & virt-manager
    bindil = $mod1, D, exec, hyprctl dispatch submap reset & dbeaver
    bindil = $mod1, L, exec, hyprctl dispatch submap reset & localsend
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Browser Mode
    submap = browser
    bindil = , Y, exec, hyprctl dispatch submap reset & brave https://youtube.com
    bindil = , G, exec, hyprctl dispatch submap reset & brave https://github.com/kanielrkirby
    bindil = , T, exec, hyprctl dispatch submap reset & brave https://trello.com/b/m5QBnONR
    bindil = , D, exec, hyprctl dispatch submap reset & brave https://discord.com/app
    bindil = , B, exec, hyprctl dispatch submap reset & brave https://libgen.is
    bindil = , C, exec, hyprctl dispatch submap reset & brave https://chat.openai.com
    bindil = , A, exec, hyprctl dispatch submap reset & brave https://amazon.com
    bindil = , L, exec, hyprctl dispatch submap reset & brave https://linkedin.com
    bindil = , N, exec, hyprctl dispatch submap reset & brave https://netlify.com
    bindil = , R, exec, hyprctl dispatch submap reset & brave https://reddit.com
    bindil = , P, exec, hyprctl dispatch submap reset & brave https://pexels.com
    bindil = , F, exec, hyprctl dispatch submap reset & brave https://my.freshbooks.com
    bindil = , M, exec, hyprctl dispatch submap reset & brave https://monkeytype.com
    bindil = , V, exec, hyprctl dispatch submap reset & brave https://vscode.dev
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # System Mode
    submap = system
    bindil = , R, exec, hyprctl dispatch submap reset & sys reboot
    bindil = , D, exec, hyprctl dispatch submap reset & sys shutdown
    bindil = , L, exec, hyprctl dispatch submap reset & sys lock
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Fan Duty Mode
    submap = fanduty
    bindil = , A, exec, hyprctl dispatch submap reset & sys fan set auto
    bindil = , grave, exec, hyprctl dispatch submap reset & sys fan set 0
    bindil = , 1, exec, hyprctl dispatch submap reset & sys fan set 10
    bindil = , 2, exec, hyprctl dispatch submap reset & sys fan set 20
    bindil = , 3, exec, hyprctl dispatch submap reset & sys fan set 30
    bindil = , 4, exec, hyprctl dispatch submap reset & sys fan set 40
    bindil = , 5, exec, hyprctl dispatch submap reset & sys fan set 50
    bindil = , 6, exec, hyprctl dispatch submap reset & sys fan set 60
    bindil = , 7, exec, hyprctl dispatch submap reset & sys fan set 70
    bindil = , 8, exec, hyprctl dispatch submap reset & sys fan set 80
    bindil = , 9, exec, hyprctl dispatch submap reset & sys fan set 90
    bindil = , 0, exec, hyprctl dispatch submap reset & sys fan set 100
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Mullvad Mode
    submap = mullvad
    bindil = , R, exec, hyprctl dispatch submap reset & mullvad reconnect --wait; if [[ "$(mullvad status)" = "Disconnected" ]]; then mullvad connect --wait; fi; notify-send "$(mullvad status)"
    bindil = , C, exec, hyprctl dispatch submap reset & if [[ "$(mullvad status)" != "Disconnected" ]]; then notify-send "Already Connected"; else mullvad connect --wait; notify-send "$(mullvad status)"; fi
    bindil = , D, exec, hyprctl dispatch submap reset & mullvad disconnect --wait; notify-send "$(mullvad status)"
    bindil = , O, exec, hyprctl dispatch submap reset & notify-send "$(mullvad status)"
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap=reset
    
    # Nightlight / Notification Mode
    submap = n
    bindil = , A, exec, hyprctl dispatch submap reset & hyprshade auto & notify-send "Nightlight: Auto"
    bindil = , 0, exec, hyprctl dispatch submap reset & hyprshade off & notify-send "Nightlight: Off"
    bindil = , 1, exec, hyprctl dispatch submap reset & hyprshade on blue-light-filter & notify-send "Nightlight: On"
    bindil = , D, exec, makoctl dismiss -a
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Syncthing Mode
    submap = syncthing
    bindil = , R, exec, hyprctl dispatch submap reset & sys syncthing restart
    bindil = , D, exec, hyprctl dispatch submap reset & sys syncthing down
    bindil = , U, exec, hyprctl dispatch submap reset & sys syncthing up
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Bluetooth Mode
    submap = bluetooth
    bindil = , C, submap, bluetooth_connect
    bindil = , D, submap, bluetooth_disconnect
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Bluetooth Connect Mode
    submap = bluetooth_connect
    bindil = , H, exec, hyprctl dispatch submap reset & sys bluetooth connect headphones &
    bindil = , M, exec, hyprctl dispatch submap reset & sys bluetooth connect mouse &
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Bluetooth Disconnect Mode
    submap = bluetooth_disconnect
    bindil = , H, exec, hyprctl dispatch submap reset & sys bluetooth disconnect headphones &
    bindil = , M, exec, hyprctl dispatch submap reset & sys bluetooth disconnect mouse &
    bindil = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Virtual Machine Mode
    submap = vm
    bindi = , U, submap, choose_vm
    bindi = , D, submap, close_vm
    bindi = , O, exec, hyprctl dispatch submap reset & virt-manager
    bindi = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Choose VM
    submap = choose_vm
    bindi = , slash , exec, hyprctl dispatch submap reset & sys virt start
    bindi = , K, exec, hyprctl dispatch submap reset & sys virt start kali-linux
    bindi = , S, exec, hyprctl dispatch submap reset & sys virt start security-onion
    bindi = , W, exec, hyprctl dispatch submap reset & sys virt start w11
    bindi = , escape, submap, reset
    bindirtl = SUPER, SUPER_L, submap, reset
    submap = reset
    
    # Close VM
    submap = close_vm
    bindi = , slash, exec, hyprctl dispatch submap reset & sys virt stop
    bindi = , K, exec, hyprctl dispatch submap reset & sys virt stop kali-linux
    bindi = , S, exec, hyprctl dispatch submap reset & sys virt stop security-onion
    bindi = , W, exec, hyprctl dispatch submap reset & sys virt stop w11
    bindi = , escape, submap, reset
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
    bind = $mod1+CTRL, 1, workspace, 11
    bind = $mod1+CTRL, 2, workspace, 12
    bind = $mod1+CTRL, 3, workspace, 13
    bind = $mod1+CTRL, 4, workspace, 14
    bind = $mod1+CTRL, 5, workspace, 15
    bind = $mod1+CTRL, 6, workspace, 16
    bind = $mod1+CTRL, 7, workspace, 17
    bind = $mod1+CTRL, 8, workspace, 18
    bind = $mod1+CTRL, 9, workspace, 19
    bind = $mod1+CTRL, 0, workspace, 20
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
    bind = $mod1 SHIFT+CTRL, 1, movetoworkspace, 11
    bind = $mod1 SHIFT+CTRL, 2, movetoworkspace, 12
    bind = $mod1 SHIFT+CTRL, 3, movetoworkspace, 13
    bind = $mod1 SHIFT+CTRL, 4, movetoworkspace, 14
    bind = $mod1 SHIFT+CTRL, 5, movetoworkspace, 15
    bind = $mod1 SHIFT+CTRL, 6, movetoworkspace, 16
    bind = $mod1 SHIFT+CTRL, 7, movetoworkspace, 17
    bind = $mod1 SHIFT+CTRL, 8, movetoworkspace, 18
    bind = $mod1 SHIFT+CTRL, 9, movetoworkspace, 19
    bind = $mod1 SHIFT+CTRL, 0, movetoworkspace, 20
    
    # Special Workspaces
    bind = $mod1, A, togglespecialworkspace, scratchpad-1
    bind = $mod1, S, togglespecialworkspace, scratchpad-2
    bind = $mod1, D, togglespecialworkspace, scratchpad-3
    bind = $mod1, F, togglespecialworkspace, scratchpad-4
    bind = $mod1 SHIFT, A, movetoworkspace, special:scratchpad-1
    bind = $mod1 SHIFT, S, movetoworkspace, special:scratchpad-2
    bind = $mod1 SHIFT, D, movetoworkspace, special:scratchpad-3
    bind = $mod1 SHIFT, F, movetoworkspace, special:scratchpad-4
    bind = $mod1, N, exec, alacritty -e sys notebook
    
    # SWITCH
    bindl= , switch:Lid Switch, exec, sys lock
    '';
  };
  #plugins = [
  #  #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
  #];
}
