{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.lazysql = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.lazysql.enable {
      home-manager.users."${config.gearshift.username}".home.packages = [
        (pkgs.callPackage ../../derivations/lazysql.nix {})
      ];
    })
  ];
}
