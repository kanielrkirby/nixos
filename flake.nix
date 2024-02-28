{
  description = "My NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.hyprland.url = "github:hyprwm/Hyprland";

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      nix-mx = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
