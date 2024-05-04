{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.fw-ectool = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.fw-ectool.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        fw-ectool
      ];
    })
  ];
}
