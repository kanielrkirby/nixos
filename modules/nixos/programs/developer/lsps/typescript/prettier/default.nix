{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.typescript.prettier;
in {
  options.${namespace}.programs.developer.lsps.typescript.prettier = {
    enable = mkBoolOpt false "Whether or not to enable the prettier.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nodePackages_latest.prettier];
  };
}
