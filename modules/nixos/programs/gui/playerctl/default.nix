{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.playerctl;
in {
  options.${namespace}.programs.gui.playerctl = {
    enable = mkBoolOpt false "Whether or not to enable playerctl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      playerctl
    ];
  };
}
