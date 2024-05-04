{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.foliate = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.foliate.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        foliate
      ];
    })
  ];
}
