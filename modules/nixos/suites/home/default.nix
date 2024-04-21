{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.suite.home = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.suite.home.enable {
      gearshift.browser.brave.enable = true;
      gearshift.localsend.enable = true;
      gearshift.mail.enable = true;
      gearshift.signal.enable = true;
      gearshift.transmission.enable = true;
    })
  ];
}
