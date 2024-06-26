{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.programs.gui.hyprlock;
in {
  options.${namespace}.programs.gui.hyprlock = {
    enable = mkBoolOpt false "Whether or not to enable hyprlock.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs; [hyprlock];
      xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
    };
  };
}
