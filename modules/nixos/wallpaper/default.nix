{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    wallpaper.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = 
    let
      wallpaper-git = pkgs.fetchFromGitHub {
        owner = "kanielrkirby";
        repo = "catppuccin";
        rev = "master";
        sha256 = "sha256-OLD5EUw4BjGPF9OWrvnyIK4gsfm3aIrUeytRmhwiKew=";
      };
      wallpaper-bin = pkgs.writeShellScriptBin "wallpaper" ''
        function clean() {
          pkill swww;
          pkill swww-daemon;
          pgrep -f wallpaper | grep -v "^$$$" | xargs -r kill;
        }

        function usage() {
          if [[ "$1" == "error" ]]; then
            echo "'wallpaper' takes one optional argument of either 'kill' or 'help'.";
          fi
          cat <<EOF
''${BASH_SOURCE[0]}
This command handles starting SWWW and automatically changing wallpapers. Just run it.
Usage:
  Start SWWW and wallpaper randomizer:
    wallpaper
  Load a new wallpaper:
    wallpaper
  Stop all related processes:
    wallpaper kill
  Show this message:
    wallpaper help
EOF
          if [[ "$1" == "error" ]]; then
            exit 1;
          fi
        }

        if [[ -n "$2" ]] || { [[ -n "$1" ]] && { [[ "$1" != "kill" ]] && [[ "$1" != "help" ]]; }; }; then
          usage error;
        fi

        if [[ -z "$1" ]]; then
          clean;

          (
            "${pkgs.swww}/bin/swww-daemon" > /dev/null 2>&1 &

            while true; do
              "${pkgs.swww}/bin/swww" img "$(fd . "${wallpaper-git}" | shuf -n1)";
              sleep "$((60*5))";
            done

            clean;
          ) > /dev/null &
        elif [[ "$1" == "kill" ]]; then
          clean;
        elif [[ "$1" == "help" ]]; then
          usage;
        fi

        exit 0;
      '';
    in
  lib.mkMerge [
    (lib.mkIf config.gearshift.wallpaper.enable {
      environment.sessionVariables = {
        WALLPAPER_DIR = wallpaper-git;
      };
      home-manager.users."${config.gearshift.username}" = {
        wayland.windowManager.hyprland.extraConfig = ''
          exec-once = ${wallpaper-bin}/bin/wallpaper start
        '';
        home.packages = [ wallpaper-bin pkgs.swww ];
      };
    })
  ];
}
