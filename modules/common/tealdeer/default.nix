{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.tealdeer.enable = mkEnableOption "TealDeer";

  config = mkIf config.gearshift.tealdeer.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.tealdeer.enable = true;
    };
  };
}
