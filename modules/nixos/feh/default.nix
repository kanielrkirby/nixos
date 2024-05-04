{ config, lib, pkgs, inputs, ... }:

with lib;
{
  options.gearshift = {
    feh.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.feh.enable {
      home-manager.users."${config.gearshift.username}" = {
        programs.feh.enable = true;
      };
    })
  ];
}
