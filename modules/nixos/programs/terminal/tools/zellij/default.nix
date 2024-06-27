{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.zellij;
in {
  options.${namespace}.programs.terminal.tools.zellij = {
    enable = mkBoolOpt false "Whether or not to enable zellij.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.zellij = {
      enable = true;
    };
  };
}
