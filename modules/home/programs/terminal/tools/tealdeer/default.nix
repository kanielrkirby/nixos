{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.rip;
in {
  options.${namespace}.programs.terminal.tools.rip = {
    enable = mkBoolOpt false "Whether or not to enable rip.";
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
    };
  };
}
