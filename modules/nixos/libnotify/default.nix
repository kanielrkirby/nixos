{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.libnotify = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.libnotify.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        libnotify
      ];
    })
  ];
}
