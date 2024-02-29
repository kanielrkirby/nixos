{ inputs, ... }:

{
  nixpkgs = {
    system = "x86_64-linux";

    config = {
      allowUnfree = true;
    };

    overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      })
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # system.copySystemConfiguration = true;

  nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  system.stateVersion = "23.11";
}
