{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.tealdeer;
in {
  options.${namespace}.programs.terminal.tools.tealdeer = {
    enable = mkBoolOpt false "Whether or not to enable tealdeer.";
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
    };
  };
}
