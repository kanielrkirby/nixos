{ config, lib, inputs, pkgs, ... }:

with lib;
{
  options.gearshift = {
    scripts.ns.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.scripts.ns.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        (writeShellScriptBin "ns" ''
          nix shell $(printf "nixpkgs#%s " "$@")
        '')
      ];
    })
  ];
}
