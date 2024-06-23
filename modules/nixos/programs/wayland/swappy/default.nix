{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wayland.swappy;
in {
  options.${namespace}.programs.wayland.swappy = {
    enable = mkBoolOpt false "Whether or not to enable swappy.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swappy
    ];
  };
}
