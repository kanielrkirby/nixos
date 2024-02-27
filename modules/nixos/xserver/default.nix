{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift = {
    xserver.enable = mkEnableOption "XServer";
  };

  config = mkIf (config.gearshift.xserver.enable) {
    services.xserver = {
      enable = true;
      xkb.layout = config.gearshift.kb-layout;
      libinput.enable = true;
      videoDrivers = [ "modesetting" ];
    };
  };
}
