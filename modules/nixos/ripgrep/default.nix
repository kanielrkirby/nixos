{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.ripgrep = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.ripgrep.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        ripgrep
      ];
    })
  ];
}
