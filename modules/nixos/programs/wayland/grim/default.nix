{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wayland.grim;
in {
  options.${namespace}.programs.wayland.grim = {
    enable = mkBoolOpt false "Whether or not to enable grim.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      grim
    ];
  };
}
