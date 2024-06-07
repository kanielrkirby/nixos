{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.wl-clipboard = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.wl-clipboard.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        wl-clipboard
      ];
    })
  ];
}
