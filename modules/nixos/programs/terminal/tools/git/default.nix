{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.git;
in {
  options.${namespace}.programs.terminal.tools.git = {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name} = {
      programs.git = {
        enable = true;
        delta.enable = true;
        userEmail = "pirate7007@runbox.com";
        userName = "Kaniel Kirby";
        extraConfig.safe.directory = ["/etc/nixos"];
      };
      programs.zsh.initExtra = ''
        ga() {
          if [ -z "$1" ]; then
            git add .
          else
            git add "$@"
          fi
        }

        gc() {
          if [ -z "$1" ]; then
            git commit
          else
            git commit -m "$*"
          fi
        }

        gp() {
          git push "$@"
        }

        gac() {
          ga
          gc "$@"
        }

        gcp() {
          gc "$@"
          gp
        }

        gacp() {
          ga
          gcp "$@"
        }

        sga() {
          if [ -z "$1" ]; then
            sudo -E git add .
          else
            sudo -E git add "$@"
          fi
        }

        sgc() {
          if [ -z "$1" ]; then
            sudo -E git commit
          else
            sudo -E git commit -m "$*"
          fi
        }

        sgp() {
          sudo -E git push "$@"
        }

        sgac() {
          sga
          sgc "$@"
        }

        sgcp() {
          sgc "$@"
          sgp
        }

        sgacp() {
          sga
          sgcp "$@"
        }
      '';
    };
  };
}
