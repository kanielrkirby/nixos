{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.${namespace}.wms.hypr;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [hypr];
    xdg.configFile."hypr/hypr.conf".text = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [../binds.conf ../hypr.conf]);
  };
}

