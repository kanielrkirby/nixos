{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.libnotify;
in {
  options.${namespace}.programs.gui.libnotify = {
    enable = mkBoolOpt false "Whether or not to enable libnotify.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libnotify
    ];
  };
}
