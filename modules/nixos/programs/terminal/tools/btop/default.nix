{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.btop;
in {
  options.${namespace}.programs.terminal.tools.btop = {
    enable = mkBoolOpt false "Whether or not to enable btop.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.btop = {
      enable = true;
    };
  };
}
