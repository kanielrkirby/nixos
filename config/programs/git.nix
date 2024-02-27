{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [ git ];

  home-manager.users."${username}" = {
    programs.gh = {
      enable = true;
      settings = {
        version = "1";
        git_protocol = "ssh";
      };
    };

    programs.git = {
      enable = true;
      userName = "Kaniel Kirby";
      userEmail = "piratey7007@runbox.com";
    };

    programs.zsh.initExtra = ''
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
}
