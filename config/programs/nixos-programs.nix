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
    ./gh-dash.nix
    ./git.nix
    ./gnupg.nix
    ./less.nix
    ./localsend.nix
    ./mods.nix
    ./mullvad.nix
    ./notify.nix
    ./ollama.nix
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

  home-manager.users."${username}".home.packages = with pkgs; [
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
  ];
}
