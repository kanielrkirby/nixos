{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.diffutils;
in {
  options.${namespace}.programs.terminal.tools.diffutils = {
    enable = mkBoolOpt false "Whether or not to enable diffutils.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      diffutils
    ];
  };
}
