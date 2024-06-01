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
        function nope() {
          nohup $@ > /dev/null 2>&1 &
        }

        if [[ -z "$@" ]] || [[ ! -z "$2" ]] || ([[ "$1" != "start" ]] && [[ "$1" != "reload" ]] && [[ "$1" != "kill" ]]); then
          echo "Must provide 1 argument [start|reload|kill]";
          exit 1;
        fi

        if [[ "$1" == "start" ]]; then
          pkill swww; 
          pkill swww-daemon;
          nope "${pkgs.swww}/bin/swww-daemon";
          _duration="$((60*5))";

          while true; do
            "${pkgs.swww}/bin/swww" img "$(fd . "${wallpaper-git}" | shuf -n1)";
            sleep "$_duration";
          done
          
          pkill swww-daemon;
        elif [[ "$1" == "kill" ]]; then
          pkill swww-daemon;
          pkill swww;
        elif [[ "$1" == "reload" ]]; then
          wallpaper kill;
          wallpaper start;
        fi
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
