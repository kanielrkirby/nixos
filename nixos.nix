{ system, locale, version, inputs, ... }:

{
  nixpkgs = {
    system = system;

    config = { allowUnfree = true; };
  };

  i18n.defaultLocale = locale;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.nixos.label = "";

  system.stateVersion = version;
}
