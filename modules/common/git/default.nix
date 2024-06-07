{ config, lib, pkgs, ... }:

{
  options.gearshift.git.enable = lib.mkEnableOption "Git";

  config = lib.mkIf config.gearshift.git.enable {
    environment.systemPackages = with pkgs; [ git ];

    home-manager.users."${config.gearshift.username}" = {
      programs = {
        gh = {
          enable = true;
          settings = {
            version = "1";
            git_protocol = "ssh";
          };
        };

        git = {
          enable = true;
          delta.enable = true;
          userName = "Kaniel Kirby";
          userEmail = "piratey7007@runbox.com";
        };

        zsh.initExtra = ''
        ga() {
          if [[ -z "$@" ]]; then
          git add .
          else
          git add "$@"
          fi
        }

        gc() {
          if [[ -z "$@" ]]; then
          git commit
          else
          git commit -m "$@"
          fi
        }

        gp() {
          git push
        }

        gac() {
          git add .
          if [[ -z "$@" ]]; then
          git commit
          else
          git commit -m "$@"
          fi
          git push
        }

        gcp() {
          if [[ -z "$@" ]]; then
          git commit
          else
          git commit -m "$@"
          fi
          git push
        }

        gacp() {
          git add .
          if [[ -z "$@" ]]; then
          git commit
          else
          git commit -m "$@"
          fi
          git push
        }
        '';
      };
    };
  };
}
