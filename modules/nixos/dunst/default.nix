{ config, lib, pkgs, inputs, ... }:

with lib;
{
  options.gearshift = {
    dunst.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.dunst.enable {
      home-manager.users."${config.gearshift.username}" = {
        services.dunst.enable = true;
      };
    })
  ];
}
