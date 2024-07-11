{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    nh.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.nh.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        nh
      ];
    })
  ];
}
