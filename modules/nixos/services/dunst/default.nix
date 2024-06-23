{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.services.dunst;
in {
  options.${namespace}.services.dunst = {
    enable = mkBoolOpt false "Whether or not to enable dunst.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      services.dunst.enable = true;
    };
  };
}
