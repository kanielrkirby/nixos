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
        pkgs=();
        while [[ "$1" != "--" && -n "$1" ]]; do
          pkgs+=("nixpkgs#$1");
          shift;
        done;
        shift;
        nix shell "''${pkgs[@]}" --command "''${@:-''${pkgs[0]#nixpkgs#}}";
        '')
      ];
    })
  ];
}
