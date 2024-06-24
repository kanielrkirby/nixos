{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.dms.sddm;
in {
  options.${namespace}.dms.sddm = {
    enable = mkBoolOpt false "Whether or not to enable sddm.";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
