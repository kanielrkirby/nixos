{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.bat = {
    enable = mkEnableOption "Bat config";
  };

  config = mkIf config.gearshift.bat.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.bat = {
        enable = true;
        config = {
          paging = "always";
        };
      };
    };
  };
}
