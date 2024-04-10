{ username, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./browser.nix
    ./eza.nix
    ./fuzzel.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gnupg.nix
    ./less.nix
    ./localsend.nix
    ./mail.nix
    ./mods.nix
    ./mpv.nix
    ./mullvad.nix
    ./notify.nix
    # ./ollama.nix
    ../derivations/goread.nix
    ./password-store.nix
    ./signal.nix
    ./sops.nix
    ./ssh.nix
    ./starship.nix
    ./swaylock.nix
    ./tealdeer.nix
    ./thunar.nix
    ./thunderbird.nix
    ./transmission.nix
    ./vscode.nix
    ./waybar.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home-manager.users."${username}" = {
    home.packages = with pkgs; [
    httpie
    nodejs_21
    wl-clipboard
    fw-ectool
    grim
    slurp
    ripgrep
    brightnessctl
    playerctl
    hyprpaper
    foliate
    gimp
    libusb
    yarn
    youtube-tui
  ];

  programs.feh.enable = true;

  programs.zsh.initExtra = ''
  n() {
    args="$@"
    cmd="''${args%% *}"
    args="''${args#* }"
    nix shell "nixpkgs#$cmd" --command $cmd $args
  }

  up() {
    local message=""
    local nopush=""
    local nogit=""
    local cmd="boot"

    for arg in "$@"; do
      case $arg in
        -l) nogit="1" ;;
        -p) nopush="1" ;;
        -b) cmd="boot" ;;
        -s) cmd="switch" ;;
        -t) cmd="test" ;;
        *) 
          if [[ -z "$message" ]]; then
            message="$arg"
          else
            echo "Error: Unexpected argument: $arg"
          fi
        ;;
      esac
    done

    current_dir="$(pwd)"
    cd /etc/nixos

    if [[ -z "$nogit" ]]; then
      sudo -E git add . 
      if [[ -z "$message" ]]; then
        echo "Must specify commit message when using Git."
        return 1
      fi
      sudo -E git commit -m "$message" 
      if [[ -z "$nopush" ]]; then
        sudo -E git push 
      fi
    fi

    if [[ -z "$cmd" ]]; then
      cmd="test"
    fi

    export NIXOS_LABEL="$message" sudo -E nixos-rebuild "$cmd" --flake /etc/nixos#default
    unset NIXOS_LABEL

    cd "$current_dir"
  }

  upp() {
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
  '';
};

  environment.systemPackages = [ pkgs.git ];
}
