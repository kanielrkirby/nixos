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
  '';
};

environment.systemPackages = [
  pkgs.git
  (pkgs.writeShellScriptBin "n" ''
    args="$@"
    cmd="$1"
    nix shell "nixpkgs#$cmd" --command $cmd ''${args#* }
  '')
  (pkgs.writeShellScriptBin "up" ''
    local message=""
    local nopush=""
    local git=""
    local cmd="boot"

    for arg in "$@"; do
      case $arg in
        -g) git="1" ;;
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

    if [[ "$git" ]]; then
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
  '')
#  (pkgs.buildGoModule rec {
#      pname = "lazysql";
#      version = "0.1.8";
#    
#      src = pkgs.fetchFromGitHub {
#        owner = "jorgerojas26";
#        repo = "lazysql";
#        rev = "v${version}";
#        hash = "sha256-m6refaJNeFhJBUatfPNm66LwTXPdD/gioT8HTv52QOw=";
#      };
#
#      buildInputs = with pkgs; [ xorg.libX11 ];
#    
#      vendorHash = "sha256-fkxEnw8l9S7WNMcPh1x7xqiQ3L61DSn6DCIvJlyrip0=";
#    
#      meta = with pkgs.lib; {
#        description = "LazySQL is awesome.";
#        homepage = "https://github.com/jorgerojas26/lazysql";
#        license = pkgs.lib.licenses.mit;
#        maintainers = with pkgs.lib.maintainers; [ ];
#      };
#  })
#  (pkgs.buildGoModule rec {
#    pname = "goread";
#    version = "1.6.4";
#  
#    src = pkgs.fetchFromGitHub {
#      owner = "TypicalAM";
#      repo = "goread";
#      rev = "v${version}";
#      hash = "sha256-yPf9/SM4uET/I8FsDU1le9JgxELu0DR9k7mv8PnBwvQ=";
#    };
#  
#    vendorHash = "sha256-/kxEnw8l9S7WNMcPh1x7xqiQ3L61DSn6DCIvJlyrip0=";
#  
#    meta = with pkgs.lib; {
#      description = "RSS reader for the terminal in BubbleTea and Golang.";
#      homepage = "https://github.com/TypicalAM/goread";
#      license = pkgs.lib.licenses.mit;
#      maintainers = with pkgs.lib.maintainers; [ ];
#    };
#  })
];
}
