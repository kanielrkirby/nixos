{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.csharp.omnisharp;
in {
  options.${namespace}.programs.developer.lsps.csharp.omnisharp = {
    enable = mkBoolOpt false "Whether or not to enable the omnisharp.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [omnisharp-roslyn];
  };
}
