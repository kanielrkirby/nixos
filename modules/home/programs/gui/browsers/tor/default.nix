{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.terminal.tools.tor;
in {
  options.${namespace}.programs.gui.terminal.tools.tor = {
    enable = mkBoolOpt false "Whether or not to enable tor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tor-browser
    ];
  };
}
