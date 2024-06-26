{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.sd;
in {
  options.${namespace}.programs.terminal.tools.sd = {
    enable = mkBoolOpt false "Whether or not to enable sd.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sd
    ];
  };
}
