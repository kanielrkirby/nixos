{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.hyprshade = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.hyprshade.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        hyprshade
      ];
    })
  ];
}
