{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.wget;
in {
  options.${namespace}.programs.terminal.tools.wget = {
    enable = mkBoolOpt false "Whether or not to enable wget.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wget
    ];
  };
}
