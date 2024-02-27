{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.lock = {
    hyprlock.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.lock.hyprlock.enable {
      home-manager.users."${config.gearshift.username}" = {
        home.packages = with pkgs; [ hyprlock ];
        xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
      };
    })
  ];
}
