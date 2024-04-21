{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.hardware = {
    powersaving.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.hardware.powersaving.enable {
      gearshift.tlp.enable = true;
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [ powertop ];
    })
  ];
}
