{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wayland.slurp;
in {
  options.${namespace}.programs.wayland.slurp = {
    enable = mkBoolOpt false "Whether or not to enable slurp.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      slurp
    ];
  };
}
