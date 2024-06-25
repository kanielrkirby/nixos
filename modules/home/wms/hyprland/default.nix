{
  pkgs,
  inputs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.wms.hyprland;
in {
  options.${namespace}.wms.hyprland = {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland = enabled;
      systemd = enabled;
      extraConfig = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./binds.conf ./main.conf]);
    };
  };
}
