{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift = {
    wm = {
      hypr = {
        enable = mkEnableOption "Hypr";
        wayland.enable = mkEnableOption "Wayland / Hyprland";
        hy3.enable = mkEnableOption "Hy3";
      };
      i3 = {
        enable = mkEnableOption "i3";
      };
    };
  };

  config = mkMerge [
    # ({
    #   assertions = [
    #     {
    #       assertion = (lib.length (lib.filter (x: x) [
    #         config.gearshift.wm.hypr.enable
    #         config.gearshift.wm.i3.enable
    #       ]) <= 1);
    #       message = "You can only have one Window Manager enabled";
    #     }
    #   ];
    # })

    (mkIf (config.gearshift.wm.hypr.enable && !config.gearshift.wm.hypr.wayland.enable) {
      gearshift.xserver.enable = true;
      home-manager.users."${config.gearshift.username}" = {
        home.packages = with pkgs; [ hypr ];
        xdg.configFile."hypr/hypr.conf".text = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./binds.conf ./hypr.conf]);
      };
      services.xserver.displayManager = {
        session = [
          {
            manage = "desktop";
            name = "Hypr";
            start = ''
              ${pkgs.hypr}/bin/hypr &amp;
              waitPID=$!
            '';
          }
        ];
      };
    })

    (mkIf (config.gearshift.wm.hypr.enable && config.gearshift.wm.hypr.wayland.enable) {
      gearshift.xserver.enable = true;
      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys =
          [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };

      home-manager = {
        users."${config.gearshift.username}" = {
          wayland.windowManager.hyprland = {
            enable = true;
            xwayland.enable = true;
            systemd.enable = true;
            extraConfig = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./binds.conf ./hypr.conf]);
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

      programs.hyprland.enable = true;

      services.xserver.displayManager = {
        session = [
          {
            manage = "desktop";
            name = "Hyprland";
            start = ''
              ${pkgs.hyprland}/bin/Hyprland &amp;
              waitPID=$!
            '';
          }
        ];
      };
    })

    (mkIf config.gearshift.wm.i3.enable {
      gearshift.xserver.enable = true;
      services = {
        xserver = {
          desktopManager.xterm.enable = false;
          windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
              i3status
              i3lock
            ];
          };
          displayManager = {
            session = [
              {
                manage = "window";
                name = "i3";
                start = ''
                  ${pkgs.i3}/bin/i3 &amp;
                  waitPID=$!
                '';
              }
            ];
          };
        };
      };
    })
  ];
}
