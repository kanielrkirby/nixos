{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.thunar;
in {
  options.${namespace}.programs.gui.thunar = {
    enable = mkBoolOpt false "Whether or not to enable thunar.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      thunar
    ];
  };
}
