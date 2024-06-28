{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.gui.launchers.wofi;
in {
  options.${namespace}.programs.gui.launchers.wofi = {
    enable = mkBoolOpt false "Whether or not to enable wofi.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.wofi = enabled;
  };
}
