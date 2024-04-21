{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    gearshift.theme.qt.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.theme.qt.enable {
      home-manager.users."${config.gearshift.username}" = {
        home.packages = with pkgs; [
          libsForQt5.qtgraphicaleffects
          libsForQt5.qtsvg
          libsForQt5.qtquickcontrols
        ];

        qt = {
          enable = true;
          platformTheme.name = "gtk";
          # style = "gtk2";
        };
      };
    })
  ];
}
