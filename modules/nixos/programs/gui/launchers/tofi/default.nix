{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.gui.launchers.tofi;
in {
  options.${namespace}.programs.gui.launchers.tofi = {
    enable = mkBoolOpt false "Whether or not to enable tofi.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.tofi = enabled;
  };
}
