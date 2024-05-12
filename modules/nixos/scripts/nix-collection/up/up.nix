{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    scripts.up.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.up.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        (writeShellScriptBin "up" ''
        __current_dir="$(pwd)"
        __cleanup() {
          __v="$1"
          if [[ -z "$__v" ]]; then
            __v=0
          fi
          unset __current_dir
          unset __cmd
          unset __message
          unset __git
          unset __nopush
          unset NIXOS_LABEL
          cd "$__current_dir"
          exit "$__v"
        }
        __message=""
        __nopush=""
        __git=""
        __cmd="test"

        for __arg in "$@"; do
          case $__arg in
            -g) __git="1" ;;
            -p) __nopush="1" ;;
            -b) __cmd="boot" ;;
            -s) __cmd="switch" ;;
            -t) __cmd="test" ;;
            *) 
              if [[ -z "$__message" ]]; then
                __message="$__arg"
              else
                echo "Error: Unexpected argument: $__arg"
                __cleanup 1
              fi
            ;;
          esac
        done

        cd /etc/nixos

        if [[ "$__git" ]]; then
          if [[ -z "$__message" ]]; then
            echo "Must specify commit message when using Git."
            __cleanup
            exit 1
          fi
          sudo -E git add . 
          sudo -E git commit -m "$__message" 
          if [[ -z "$__nopush" ]]; then
            sudo -E git push 
          fi
        fi

        export NIXOS_LABEL="$__message"

        sudo -E nixos-rebuild "$__cmd" --flake /etc/nixos#eclipse
        __cleanup
        '')
      ];
    })
  ];
}
