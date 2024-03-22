{ pkgs, username, ... }:

{
  programs.zsh.enable = true;

  users = { defaultUserShell = pkgs.zsh; };

  home-manager.users."${username}" = {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      initExtra = ''
        export LANG="en_US.UTF-8"
        export LC_ALL="$LANG"

        alias svim="sudo -E -s nvim"

        up() {
            local name=""
            local type="test"  # Default type

            for arg in "$@"; do
                case $arg in
                    --boot)
                        type="boot"
                        shift
                        ;;
                    --switch)
                        type="switch"
                        shift
                        ;;
                    --test)
                        type="test"
                        shift
                        ;;
                    *)
                        # Assuming the first non-option argument is the name
                        if [[ -z "$name" ]]; then
                            name="$arg"
                        else
                            echo "Error: Unexpected argument: $arg"
                            return 1
                        fi
                        ;;
                esac
            done

            if [[ -z "$name" ]]; then
                echo "Error: Name is required."
                return 1
            fi

            name="$(echo $name | sed "s/ /_/g")"

            sudo NIXOS_LABEL="$name" nixos-rebuild "$type" --flake /etc/nixos#nixos

            wd=$(pwd)
            if [[ "$type" == "boot" || "$type" == "switch" ]]; then
              cd /etc/nixos
              sudo -E git add .
              sudo -E git commit -m "$name"
              cd "$wd"
            fi
        }

        n() {
          args="$@"
          cmd="''${args%% *}"
          args="''${args#* }"
          nix shell "nixpkgs#$cmd" --command $cmd $args
        }

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

    programs.atuin = { enableZshIntegration = true; };

    programs.starship = { enableZshIntegration = true; };

    programs.fzf = { enableZshIntegration = true; };

    programs.zoxide = { enableZshIntegration = true; };
  };
}
