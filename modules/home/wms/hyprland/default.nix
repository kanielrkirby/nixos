{
  pkgs,
  inputs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (inputs) catppuccin;
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.themes.catppuccin;
in {
  options.${namespace}.themes.catppuccin = {
    enable = mkBoolOpt false "Whether or not to enable catppuccin.";
  };

  imports = [
    catppuccin.nixosModules.catppuccin
  ];

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland = enabled;
      systemd = enabled;
      extraConfig = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./hypr/binds.conf ./hypr/main.conf]);
    };
  };
}
