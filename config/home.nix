{ inputs, username, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./alacritty.nix
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./chromium.nix
    ./eza.nix
    ./fuzzel.nix
    ./fzf.nix
    ./git.nix
    ./less.nix
    ./mako.nix
    ./password-store.nix
    ./starship.nix
    ./swaylock.nix
    ./tealdeer.nix
    ./thunar.nix
    ./thunderbird.nix
    ./vscode.nix
    ./waybar.nix
    ./zoxide.nix
    ./zsh.nix

    ./theme/color.nix
    ./theme/gtk.nix
    ./theme/qt.nix
  ];

  home-manager = {
    useGlobalPkgs = true;

    users."${username}" = {
      home.stateVersion = "23.11";

      home.packages = with pkgs; [
        libnotify
        httpie
        nodejs_21
        wl-clipboard
        fw-ectool
        pinentry
        grim
        slurp
        ripgrep
        hyprshade
        signal-desktop
        brightnessctl
        playerctl
        hyprpaper
        codeium
        localsend
        foliate
        gimp
      ];
    };
  };
}
