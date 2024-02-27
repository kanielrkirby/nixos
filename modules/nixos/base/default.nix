{ config, lib, inputs, pkgs, ... }:

with lib;
{
  options.gearshift = {
    username = mkOption {
      type = types.str;
      default = "mx";
    };
    version = {
      main = mkOption {
        type = types.str;
        default = "24.05";
      };
      home = mkOption {
        type = types.str;
        default = "23.11";
      };
    };
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
    };
    kb-layout = mkOption {
      type = types.str;
      default = "us";
    };
    timeZone = mkOption {
      type = types.str;
      default = "America/Chicago";
    };
    hostName = mkOption {
      type = types.str;
    };
    hostId = mkOption {
      type = types.str;
      default = "3759be58";
    };
  };

  config = {
    i18n.defaultLocale = config.gearshift.locale;
  
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

    system.nixos.label = "";


    home-manager = {
      useGlobalPkgs = true;

      users."${config.gearshift.username}" = {
        xdg.configFile."nom/config.yml".text = ''
          feeds:
            - url: https://nixos.org/blog/feed.xml
              name: NixOS Official Blog
            - url: https://old.reddit.com/r/NixOS/.rss
              name: NixOS Reddit
            - url: https://github.com/nix-community/awesome-nix/commits.atom
              name: NixOS Awesome GitHub
            - url: https://hnrss.org/newest?q=Nix+OR+NixOS
              name: NixOS HN Threads
            - url: https://hnrss.org/newcomments?q=Nix+OR+NixOS
              name: NixOS HN Comments
            - url: https://hackernoon.com/tagged/nixos/feed
              name: NixOS Hackernoon
            - url: https://hackernoon.com/tagged/react/feed
              name: React Hackernoon
            - url: https://hackernoon.com/tagged/javascript/feed
              name: JavaScript Hackernoon
            - url: https://hackernoon.com/tagged/frontend/feed
              name: Frontend Hackernoon
            - url: https://hnrss.org/newest?q=Web+Development+OR+webdev+OR+react+OR+javascript+OR+html+OR+css+OR+typescript
              name: Web Dev Hacker News
            - url: https://old.reddit.com/r/webdev/.rss
              name: Web Dev Reddit
            - url: https://github.com/gorhill/uBlock/wiki.atom
              name: uBlock GitHub
        '';
  
        programs.feh.enable = true;
  
        programs.zsh.initExtra = ''
        '';
        home = {
          stateVersion = config.gearshift.version.home;
          packages = with pkgs; [
            libnotify
            hyprshade
            fw-ectool
            httpie
            wl-clipboard
            grim
            slurp
            ripgrep
            brightnessctl
            playerctl
            foliate
            yarn
            youtube-tui
            nom
            wf-recorder
          ];
        };
      };
    };

    environment.systemPackages = with pkgs; [
      git
      (writeShellScriptBin "n" ''
        __args="$@"
        __cmd="$1"
        nix shell "nixpkgs#$__cmd" --command $__cmd ''${__args#* }
      '')
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

      sudo -E nixos-rebuild "$__cmd" --flake /etc/nixos#default
      __cleanup
      '')
      (callPackage ../../derivations/goread.nix {})
      (callPackage ../../derivations/lazysql.nix {})
      (callPackage ../../derivations/smassh.nix {})
    ];

    system.stateVersion = config.gearshift.version.main;
  };
}
