{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.wms.hypr;
in {
  options.${namespace}.wms.hypr = {
    enable = mkBoolOpt false "Whether or not to enable hypr.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [hypr];
    xdg.configFile."hypr/hypr.conf".text = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [../binds.conf ../hypr.conf]);
  };
}

