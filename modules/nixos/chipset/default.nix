{ pkgs, config, lib, ... }:

{
  options.gearshift.hardware = {
    intel.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    amd.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    nvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = lib.length (lib.filter (x: x) [
            config.gearshift.hardware.intel.enable
            config.gearshift.hardware.amd.enable
            config.gearshift.hardware.nvidia.enable
          ]) <= 1;
          message = "You can only enable one chipset type for gearshift.hardware.";
        }
        {
          assertion = !(config.gearshift.hardware.amd.enable || config.gearshift.hardware.nvidia.enable);
          message = "AMD and NVidia don't work, as I don't have them, so I've never tried it :)";
        }
      ];
    }
    (lib.mkIf config.gearshift.hardware.intel.enable {
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
      environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
    })
  ];
}
