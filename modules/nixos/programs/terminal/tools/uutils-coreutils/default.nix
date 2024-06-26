{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.coreutils;
in {
  options.${namespace}.programs.terminal.tools.coreutils = {
    enable = mkBoolOpt false "Whether or not to enable coreutils.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      uutils-coreutils-noprefix
    ];
  };
}
