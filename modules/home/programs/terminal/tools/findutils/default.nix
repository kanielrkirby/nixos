{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.findutils;
in {
  options.${namespace}.programs.terminal.tools.findutils = {
    enable = mkBoolOpt false "Whether or not to enable findutils.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      findutils
    ];
  };
}
