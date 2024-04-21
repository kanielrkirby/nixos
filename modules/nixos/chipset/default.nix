{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.hardware = {
    intel.enable = mkOption {
      type = types.bool;
      default = false;
    };
    amd.enable = mkOption {
      type = types.bool;
      default = false;
    };
    nvidia.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    ({
      assertions = [
        {
          assertion = (lib.length (lib.filter (x: x) [
            config.gearshift.hardware.intel.enable
            config.gearshift.hardware.amd.enable
            config.gearshift.hardware.nvidia.enable
          ]) <= 1);
          message = "You can only enable one chipset type for gearshift.hardware.";
        }
        {
          assertion = !(config.gearshift.hardware.amd.enable || config.gearshift.hardware.nvidia.enable);
          message = "AMD and NVidia don't work, as I don't have them, so I've never tried it :)";
        }
      ];
    })
    (mkIf config.gearshift.hardware.intel.enable {
      hardware = {
        opengl = {
          enable = true;
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = with pkgs; [
            intel-media-driver
            vaapiVdpau
            libvdpau-va-gl
          ];
        };
      };
      environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
    })
  ];
}
