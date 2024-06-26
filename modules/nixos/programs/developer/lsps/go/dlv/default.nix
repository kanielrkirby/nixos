{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.go.dlv;
in {
  options.${namespace}.programs.developer.lsps.go.dlv = {
    enable = mkBoolOpt false "Whether or not to enable the dlv.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [delve];
  };
}
