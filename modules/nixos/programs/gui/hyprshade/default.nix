{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.hyprshade;
in {
  options.${namespace}.programs.gui.hyprshade = {
    enable = mkBoolOpt false "Whether or not to enable hyprshade.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprshade
    ];
  };
}
