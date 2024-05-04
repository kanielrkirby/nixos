{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.playerctl = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.playerctl.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        playerctl
      ];
    })
  ];
}
