{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.nix.nil;
in {
  options.${namespace}.programs.developer.lsps.nix.nil = {
    enable = mkBoolOpt false "Whether or not to enable the nil.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nil];
  };
}
