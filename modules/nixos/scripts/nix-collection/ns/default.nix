{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    scripts.ns.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.ns.enable {
      home-manager.users."${config.gearshift.username}".home.packages = [
        (pkgs.writeShellScriptBin "ns" ''
          nix shell $(printf "nixpkgs#%s " "$@")
        '')
      ];
    })
  ];
}
