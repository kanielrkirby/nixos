{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.mpv;
in {
  options.${namespace}.programs.gui.mpv = {
    enable = mkBoolOpt false "Whether or not to enable mpv.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mpv
    ];
  };
}
