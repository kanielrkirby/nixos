{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.terminal.tools.firefox;
in {
  options.${namespace}.programs.gui.terminal.tools.firefox = {
    enable = mkBoolOpt false "Whether or not to enable firefox.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [firefox];
  };
}
