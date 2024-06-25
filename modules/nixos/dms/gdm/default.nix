{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.dms.gdm;
in {
  options.${namespace}.dms.gdm = {
    enable = mkBoolOpt false "Whether or not to enable gdm.";
  };

  config = mkIf cfg.enable {
    ${namespace}.services.xserver = enabled;
    services.xserver.displayManager = {
      gdm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
