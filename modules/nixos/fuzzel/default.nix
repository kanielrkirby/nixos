{ config, lib, pkgs, inputs, ... }:

with lib;
{
  options.gearshift = {
    fuzzel.enable = mkEnableOption "Fuzzel"; 
  };

  config = mkMerge [
    (mkIf config.gearshift.fuzzel.enable {
      home-manager.users."${config.gearshift.username}" = {
        programs.fuzzel.enable = true;
      };
    })
  ];
}
