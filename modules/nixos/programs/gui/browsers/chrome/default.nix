{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.browsers.chrome;
in {
  options.${namespace}.programs.gui.browsers.chrome = {
    enable = mkBoolOpt false "Whether or not to enable chrome.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];
  };
}
