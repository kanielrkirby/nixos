{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.gh;
in {
  options.${namespace}.programs.terminal.tools.gh = {
    enable = mkBoolOpt false "Whether or not to enable gh.";
  };

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
    };
  };
}
