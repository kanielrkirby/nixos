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
        if [[ -z "$@" ]] || [[ ! -z "$2" ]] || ([[ "$1" != "start" ]] && [[ "$1" != "reload" ]] && [[ "$1" != "kill" ]]); then
          echo "Must provide 1 argument [start|reload|kill]";
          exit 1;
        fi

        nohup $(
          if [[ "$1" == "start" ]]; then
            nohup "${pkgs.hyprpaper}/bin/hyprpaper" > /dev/null 2>&1 &
            WALLPAPER_DIR="${wallpaper-git}";
            _duration="$((60*15))";

            _get_wallpaper() {
              items="$(ls -1 "$WALLPAPER_DIR")";
              length="$(echo "$items" | wc -l)";
              line_number="$((1 + RANDOM % length))";
              nth_line="$(echo "$items" | head -n "$line_number" | tail -n 1)";
              echo "$WALLPAPER_DIR/$nth_line";
            }

            while true; do
              _monitor="$(hyprctl monitors | head -n 1 | awk '{print $2}')";
              _wallpaper_path="$(_get_wallpaper)";
              hyprctl hyprpaper preload "$_wallpaper_path";
              hyprctl hyprpaper wallpaper "$_monitor,$_wallpaper_path";
              hyprctl hyprpaper unload all;
              sleep "$_duration";
            done
            
            pkill hyprpaper;
          elif [[ "$1" == "kill" ]]; then
            hyprctl hyprpaper unload all;
            pkill hyprpaper;
          elif [[ "$1" == "reload" ]]; then
            wallpaper kill;
            sleep 1;
            wallpaper start;
          fi
        ) > /dev/null 2>&1 &
      '';
    in
  lib.mkMerge [
    (lib.mkIf config.gearshift.wallpaper.enable {
      home-manager.users."${config.gearshift.username}" = {
        wayland.windowManager.hyprland.extraConfig = ''
          exec-once = ${wallpaper-bin}/bin/wallpaper start
        '';
        home.packages = [ wallpaper-bin ];
      };
    })
  ];
}
