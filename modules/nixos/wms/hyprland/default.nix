{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.wms.hyprland;
in {
  options.${namespace}.wms.hyprland = {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  config = mkMerge [
    (mkIf (cfg.enable && config.${namespace}.user.name != null) {
      snowfallorg.users.${config.${namespace}.user.name}.wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland = enabled;
        systemd = enabled;
        extraConfig = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./binds.conf ./main.conf]);
      };
    })
    (mkIf cfg.enable {
      ${namespace}.services.xserver = enabled;
      nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
    })
  ];
}
