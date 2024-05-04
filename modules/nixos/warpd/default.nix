{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.warpd = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.warpd.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        warpd
      ];
    })
  ];
}
