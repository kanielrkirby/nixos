{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.services.dunst;
in {
  options.${namespace}.services.dunst = {
    enable = mkBoolOpt false "Whether or not to enable dunst.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.services.dunst = enabled;
  };
}
