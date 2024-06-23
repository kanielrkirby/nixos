{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.dms.sddm;
in {
  options.${namespace}.dms.sddm = {
    enable = mkBoolOpt false "Whether or not to enable sddm.";
  };

  config = mkIf cfg.enable {
    ${namespace}.services.xserver = enabled;
    services.xserver.displayManager = {
      sddm = {
        package = pkgs.kdePackages.sddm;
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
