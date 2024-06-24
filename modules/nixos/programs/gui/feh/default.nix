{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.feh;
in {
  options.${namespace}.programs.gui.feh = {
    enable = mkBoolOpt false "Whether or not to enable feh.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [feh];
  };
}
