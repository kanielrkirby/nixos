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

  config = mkIf (cfg.enable && config.${namespace}.user.name != null) {
    snowfallorg.users.${config.${namespace}.user.name}.home.config.programs.btop = {
      enable = true;
    };
  };
}
