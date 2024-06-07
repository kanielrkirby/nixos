{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.suite.theme = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.suite.theme.enable {
      gearshift.theme.font.monaspace.enable = true;
      gearshift.theme.font.noto-sans.enable = true;
      gearshift.theme.catppuccin.enable = true;
      gearshift.theme.gtk.enable = true;
      gearshift.theme.qt.enable = true;
    })
  ];
}


