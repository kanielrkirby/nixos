{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland/main";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim.url = "github:nix-community/nixvim/nixos-23.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, impermanence, ... }@inputs:
    let
      system = "x86_64-linux";
      kernel = "6_7";
      version = "23.11";
      hostName = "nixos";
      username = "mx";
      locale = "en_US.UTF-8";
      kbLayout = "us";
      timeZone = "America/Chicago";
#      wallpaperGit = "https://github.com/amtoine/wallpapers";
#      wallpaperDir = "/home/${username}/.config/wallpapers";
#      wallpaperSubDir = "/home/${username}/.config/wallpapers/wallpapers/other";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              system = system;
              config.allowUnfree = true;
            };
          })
        ];
      };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            inherit system;
            inherit kernel;
            inherit version;
            inherit inputs;
            inherit hostName;
            inherit username;
            inherit timeZone;
            inherit locale;
            inherit kbLayout;
#            inherit wallpaperDir;
#            inherit wallpaperSubDir;
#            inherit wallpaperGit;
            inherit pkgs;
          };
          modules = [
            impermanence.nixosModules.impermanence
            ./config/impermanence.nix
            ./hardware-configuration.nix
            ./config/nixos.nix
            ./config/boot.nix
            ./config/hardware.nix
            ./config/packages.nix
            ./config/home.nix
            ./config/desktop-environment.nix
            ./config/nixvim.nix
            ./config/network.nix
            ./config/virtualization.nix
#            ./config/hyprpaper.nix
          ];
        };
      };
    };
}
