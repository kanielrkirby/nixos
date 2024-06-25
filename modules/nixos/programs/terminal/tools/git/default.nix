{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.git;
in {
  options.${namespace}.programs.terminal.tools.git = {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.name != null) {
    snowfallorg.users.${config.${namespace}.user.name}.programs.git = {
      enable = true;
    };
  };
}
