{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.hardware = {
    sound = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.hardware.sound.enable {
      sound.enable = true;
    })
  ];
}
