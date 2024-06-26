{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.browsers.firefox;
in {
  options.${namespace}.programs.gui.browsers.firefox = {
    enable = mkBoolOpt false "Whether or not to enable firefox.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [firefox];
  };
}
