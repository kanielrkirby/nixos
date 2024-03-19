{ username, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./chromium.nix
    ./eza.nix
    ./fuzzel.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./less.nix
    ./localsend.nix
    ./mullvad.nix
    ./notify.nix
    ./password-store.nix
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

  home-manager.users."${username}".home.packages = with pkgs; [
    httpie
    nodejs_21
    wl-clipboard
    fw-ectool
    grim
    slurp
    ripgrep
    signal-desktop
    brightnessctl
    playerctl
    hyprpaper
    foliate
    gimp
  ];
}
