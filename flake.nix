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
  };

  outputs = { nixpkgs, ... } @ inputs:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
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
            import ./config/hyprpaper.nix {
                inherit nixpkgs;
                username = "mx";
                wallpaperDir = "/nixos/etc/extra/wallpapers";
                wallpaperGit = "https://github.com/antoniosarosi/Wallpapers.git";
            }
          ];
        };
      };
    };
}
