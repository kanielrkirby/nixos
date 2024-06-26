{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.gnupg;
in {
  options.${namespace}.programs.terminal.tools.gnupg = {
    enable = mkBoolOpt false "Whether or not to enable gnupg.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnupg
    ];
  };
}
