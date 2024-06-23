{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.opengl;
in {
  options.${namespace}.hardware.opengl = {
    enable = mkBoolOpt false "Whether or not to enable opengl.";
  };

  config = mkIf cfg.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
          intel-ocl
          libvdpau-va-gl
          vulkan-tools
          vaapiIntel
          vaapiVdpau
          mesa.drivers
        ];
      };
    };
    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  };
}
