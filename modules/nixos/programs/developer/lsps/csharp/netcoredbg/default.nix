{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.csharp.netcoredbg;
in {
  options.${namespace}.programs.developer.lsps.csharp.netcoredbg = {
    enable = mkBoolOpt false "Whether or not to enable the netcoredbg.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [netcoredbg];
  };
}
