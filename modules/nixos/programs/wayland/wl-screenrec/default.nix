{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wayland.wl-screenrec;
in {
  options.${namespace}.programs.wayland.wl-screenrec = {
    enable = mkBoolOpt false "Whether or not to enable wl-screenrec.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-screenrec
    ];
  };
}
