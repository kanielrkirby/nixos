{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.less.enable = mkEnableOption "Less";

  config = mkIf config.gearshift.less.enable {
    home-manager.users."${config.gearshift.username}" = { programs.less = { enable = true; }; };
  };
}

