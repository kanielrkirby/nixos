{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    scripts.nope = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.nope.enable {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "nope" ''
          nohup "$@" > /dev/null 2>&1 &
        '')
      ];
    })
  ];
}
