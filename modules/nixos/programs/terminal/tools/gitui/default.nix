{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.gitui;
in {
  options.${namespace}.programs.terminal.tools.gitui = {
    enable = mkBoolOpt false "Whether or not to enable gitui.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name} = {
      programs.gitui = {
        enable = true;
      };
    };
  };
}
