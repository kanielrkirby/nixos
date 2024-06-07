{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.yarn = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.yarn.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        yarn
      ];
    })
  ];
}
