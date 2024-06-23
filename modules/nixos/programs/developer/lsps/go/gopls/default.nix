{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.go.gopls;
in {
  options.${namespace}.programs.developer.lsps.go.gopls = {
    enable = mkBoolOpt false "Whether or not to enable the gopls.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [gopls];
  };
}
