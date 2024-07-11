{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.brightnessctl = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.brightnessctl.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        brightnessctl
      ];
    })
  ];
}
