{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.dms.gdm;
in {
  options.${namespace}.dms.gdm = {
    enable = mkBoolOpt false "Whether or not to enable gdm.";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager = {
      gdm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
