{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.zoxide.enable = mkEnableOption "Zoxide";

  config = mkIf config.gearshift.zoxide.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.zoxide = {
        enable = true;
      };
    };
  };
}
