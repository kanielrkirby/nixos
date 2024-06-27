{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.markdown.marksman;
in {
  options.${namespace}.programs.developer.lsps.markdown.marksman = {
    enable = mkBoolOpt false "Whether or not to enable the marksman.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [marksman];
  };
}
