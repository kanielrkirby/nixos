{
  description = "My NixOS configuration";

  inputs = {
      hyprland.url = "github:hyprwm/Hyprland";

      nixpkgs.url = "github:NixOS/nixpkgs/d8e0944e6d2ce0f326040e654c07a410e2617d47";
      # Switch to unstable when the problem above is fixed
      #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = {nixpkgs, home-manager, ...} @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
