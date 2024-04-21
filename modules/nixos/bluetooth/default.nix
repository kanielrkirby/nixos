{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.hardware = {
    sound = {
      bluetooth.enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkMerge [
    (mkIf (config.gearshift.hardware.sound.enable && config.gearshift.hardware.sound.bluetooth.enable) {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      services.blueman.enable = true;
    })
  ];
}

