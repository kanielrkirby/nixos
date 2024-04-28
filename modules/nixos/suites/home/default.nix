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
      gearshift = {
        browser.brave.enable = true;
        localsend.enable = true;
        mail.enable = true;
        signal.enable = true;
        transmission.enable = true;
        fuzzel.enable = true;
      };
    })
  ];
}
