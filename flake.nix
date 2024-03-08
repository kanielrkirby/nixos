{
  description = "My NixOS configuration";

  inputs = {
    nixos-pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos-pkgs";
    hyprland.url = "github:hyprwm/Hyprland/main";
    hyprland.inputs.nixpkgs.follows = "nixos-pkgs";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixos-pkgs";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixos-pkgs, impermanence, ... }@inputs:
    let
      system = "x86_64-linux";
      # kernel = "6_7"; # Commented out for ZFS to handle it
      version = "23.11";
      hostName = "nixos";
      username = "mx";
      locale = "en_US.UTF-8";
      kbLayout = "us";
      timeZone = "America/Chicago";
      wallpaperGit = "https://github.com/Gingeh/wallpapers";
      wallpaperDir = "/home/${username}/.config/wallpapers";
      wallpaperSubDir = "/home/${username}/.config/wallpapers/wallpapers/other";
      pkgs = import nixos-pkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in {
      nixosConfigurations = {
        nixos = nixos-pkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            inherit system;
            # inherit kernel; # for ZFS
            inherit version;
            inherit inputs;
            inherit hostName;
            inherit username;
            inherit timeZone;
            inherit locale;
            inherit kbLayout;
            inherit wallpaperDir;
            inherit wallpaperSubDir;
            inherit wallpaperGit;
            inherit pkgs;
            inherit impermanence;
          };
          modules = [
            ./config/impermanence.nix
            ./hardware-configuration.nix
            ./config/nixos.nix
            ./config/boot
            ./config/hardware.nix
            ./config/packages.nix
            ./config/home.nix
            ./config/hyprland
            ./config/nixvim
            ./config/network.nix
            ./config/virt
            ./config/hyprpaper.nix
          ];
        };
      };
    };
}
