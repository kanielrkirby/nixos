{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lazysql;
in {
  options.${namespace}.programs.developer.lazysql = {
    enable = mkBoolOpt false "Whether or not to enable lazysql.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lazysql
    ];
  };
}
