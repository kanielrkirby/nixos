{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.hyprlock;
in {
  options.${namespace}.programs.gui.hyprlock = {
    enable = mkBoolOpt false "Whether or not to enable hyprlock.";
  };

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      extraConfig = ./hyprlock.conf;
    };
  };
}
