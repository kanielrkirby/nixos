{
  inputs,
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
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      home-manager.users.${config.${namespace}.user.name}.wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland = enabled;
        systemd = enabled;
        extraConfig = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./binds.conf ./main.conf]);
      };
    })
    (mkIf cfg.enable {
      ${namespace}.services.xserver = enabled;
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
