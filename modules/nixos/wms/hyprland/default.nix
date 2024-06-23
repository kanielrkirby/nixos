{
  pkgs,
  config,
  lib,
  namespace,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username enabled;

  cfg = config.${namespace}.wms.hyprland;
in {
  options.${namespace}.wms.hyprland = {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      wms.xserver = enabled;
    };
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    home-manager = {
      users.${username} = {
        wayland.windowManager.hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          xwayland = enabled;
          systemd = enabled;
          extraConfig = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./hypr/binds.conf ./hypr/main.conf]);
        };
      };
    };

    xdg.portal = {
      wlr = enabled;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };

    programs.hyprland = enabled;

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
  };
}
