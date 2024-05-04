{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.waybar = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.waybar.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        waybar
      ];
    })
  ];
}
