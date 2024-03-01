{ system, locale, version, inputs, ... }:

{
  nixpkgs = {
    system = system;

    config = {
      allowUnfree = true;
    };

    overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = system;
          config.allowUnfree = true;
        };
      })
    ];
  };

  i18n.defaultLocale = locale;

  # system.copySystemConfiguration = true;

  nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  system.nixos.label = "";

  system.stateVersion = version;
}
