{ inputs, username, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./programs/nixos-programs.nix

    ./theme/color.nix
    ./theme/gtk.nix
    ./theme/qt.nix

    ./sddm.nix
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
    };
  };
}
