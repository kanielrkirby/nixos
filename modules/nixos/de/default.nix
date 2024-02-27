{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift = {
    de = {
      plasma = {
        enable = mkEnableOption "KDE Plasma";
      };
      mate = {
        enable = mkEnableOption "MATE";
      };
      xfce = {
        enable = mkEnableOption "XFCE";
      };
    };
  };

  config = mkMerge [
    ({
      assertions = [
        {
          assertion = (lib.length (lib.filter (x: x) [
            config.gearshift.de.plasma.enable
            config.gearshift.de.mate.enable
            config.gearshift.de.xfce.enable
          ]) <= 1);
          message = "You can only have one Desktop Environment enabled";
        }
      ];
    })

    (mkIf config.gearshift.de.plasma.enable {
    })

    (mkIf config.gearshift.de.mate.enable {
    })

    (mkIf config.gearshift.de.xfce.enable {
    })
  ];
}
