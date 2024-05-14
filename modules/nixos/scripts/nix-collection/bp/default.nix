{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    scripts.bp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      NIX_BP_DIR = lib.mkOption {
        type = lib.types.str;
        default = "/etc/nixos/examples/blueprints";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.bp.enable {
      home-manager.users."${config.gearshift.username}".home.packages = [
        (pkgs.writeShellScriptBin "bp" ''
        NIX_BP_DIR="${config.gearshift.scripts.bp.NIX_BP_DIR}";

        starting_directory="$(pwd)";

        if [[ $@ == "" ]]; then
          echo "No args passed.";
          echo "$(ls $NIX_BP_DIR)";
          exit 1;
        fi

        for arg in $@; do
          if [[ ! -f "$NIX_BP_DIR/$arg/flake.nix" ]]; then
            echo "File at $NIX_BP_DIR/$arg/flake.nix not found.";
            exit 1;
          fi
        done

        cd "$starting_directory";

        for arg in $@; do
          cp "$NIX_BP_DIR/$arg/flake.nix" "./$arg.nix";
        done
        '')
      ];
    })
  ];
}
