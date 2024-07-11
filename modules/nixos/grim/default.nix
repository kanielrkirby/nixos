{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.grim = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.grim.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        grim
      ];
    })
  ];
}
