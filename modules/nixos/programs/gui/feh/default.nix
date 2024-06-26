{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.gui.feh;
in {
  options.${namespace}.programs.gui.feh = {
    enable = mkBoolOpt false "Whether or not to enable feh.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.feh = enabled;
  };
}
