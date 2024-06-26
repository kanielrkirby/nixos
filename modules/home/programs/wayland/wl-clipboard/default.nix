{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wayland.wl-clipboard;
in {
  options.${namespace}.programs.wayland.wl-clipboard = {
    enable = mkBoolOpt false "Whether or not to enable wl-clipboard.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
