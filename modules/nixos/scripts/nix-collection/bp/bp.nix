{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    scripts.bp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.up.enable {
      home-manager.users."${config.gearshift.username}".home.packages = [
        (pkgs.writeShellScriptBin "bp" ''
        cd /etc/nixos/examples/dev-shells

        if [[ $@ == "" ]]; then
          echo "No args passed.";
          exit 1;
        fi

        for arg in $@; do
          if [ -z "$(ls -a "$arg/flake.nix")" ]; then
            echo "$arg not in $(pwd).";
            exit 1;
          fi
        done

        for arg in $@; do
          nix develop ./"$arg";
        done
        '')
      ];
    })
  ];
}
