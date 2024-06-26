{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.gui.launchers.fuzzel;
in {
  options.${namespace}.programs.gui.launchers.fuzzel = {
    enable = mkBoolOpt false "Whether or not to enable fuzzel.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.fuzzel = enabled;
  };
}
