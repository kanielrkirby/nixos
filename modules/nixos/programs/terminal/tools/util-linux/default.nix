{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.util-linux;
in {
  options.${namespace}.programs.terminal.tools.util-linux = {
    enable = mkBoolOpt false "Whether or not to enable util-linux.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      util-linux
    ];
  };
}
