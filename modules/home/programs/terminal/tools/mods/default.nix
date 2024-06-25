{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.mods;
in {
  options.${namespace}.programs.terminal.tools.mods = {
    enable = mkBoolOpt false "Whether or not to enable mods.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [mods];
    # xdg.configFile."mods.yml" = config.sops.templates."mods.yml".path;
    programs.zsh.initExtra = ''
      np() {
        __path="/tmp/__np_mods.txt"
        __model="gpt-3.5-turbo"

        for arg in "$@"; do
        case $arg in
        -m)
        if [ -z "$2" ]; then
        echo "Error: No model passed to np, but flag `-m` present."
        return 1
        fi
        __model="$2"
        shift; shift;
        ;;
        esac
        done

        nvim "$__path"
        if [ ! -f "$__path" ]; then
        echo "Error: No file passed to np."
        return 1
        fi

        __content="$(cat "$__path")"
        rm "$__path"

        if [ "$__content" = "" ]; then
        echo "Error: No content passed to np."
        return 1
        fi

        mods -m "$__model" "$__content"
      }
    '';
  };
}

