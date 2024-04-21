{ config, lib, pkgs, ... }:

with lib;
{
  config = {
    users = {
      users."${config.gearshift.username}" = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        initialPassword = "asdf";
      };
      mutableUsers = false;
    };
  };
}
