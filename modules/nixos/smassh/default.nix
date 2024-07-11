{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.smassh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.smassh.enable {
      home-manager.users."${config.gearshift.username}".home.packages = [
        (pkgs.callPackage ../../derivations/smassh.nix {})
      ];
    })
  ];
}
