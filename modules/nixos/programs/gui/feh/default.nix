{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.programs.gui.feh;
in {
  options.${namespace}.programs.gui.feh = {
    enable = mkBoolOpt false "Whether or not to enable feh.";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username}.programs.feh.enable = true;
  };
}
