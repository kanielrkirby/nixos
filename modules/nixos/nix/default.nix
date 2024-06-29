{
  inputs,
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) filterAttrs isType mapAttrs mapAttrsToList mkDefault mkIf pipe;
  inherit (lib.types) str;
  inherit (lib.${namespace}) mkBoolOpt mkOpt disabled;

  cfg = config.${namespace}.nix.defaultSettings;
in {
  options.${namespace} = {
    user = {
      enable = mkBoolOpt false "Whether or not to configure a user for this system";
      name = mkOpt str "mx" "The default username used on this system.";
    };
    nix.defaultSettings = {
      enable = mkBoolOpt false "Whether or not to set the default settings.";
    };
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";
    users.users.${config.${namespace}.user.name} = {
      isNormalUser = true;
      group = config.${namespace}.user.name;
      extraGroups = [ "wheel" ];
    };
    users.groups.${config.${namespace}.user.name} = {};
    home-manager.users.${config.${namespace}.user.name}.imports = with inputs; [
      catppuccin.homeManagerModules.catppuccin
      nix-index-database.hmModules.nix-index
    ];

    # faster rebuilding
    documentation = {
      doc = disabled;
      info = disabled;
      man.enable = mkDefault true;
    };
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
    environment = {
      etc = with inputs; {
        # set channels (backwards compatibility)
        "nix/flake-channels/system".source = self;
        "nix/flake-channels/nixpkgs".source = nixpkgs;
        "nix/flake-channels/home-manager".source = home-manager;

        # preserve current flake in /etc
        "nixos/flake".source = self;
      };

      systemPackages = with pkgs; [
        cachix
        deploy-rs
        git
        nix-prefetch-git
      ];
    };

    nix = let
      mappedRegistry = pipe inputs [
        (filterAttrs (_: isType "flake"))
        (mapAttrs (_: flake: {inherit flake;}))
        (x: x // {nixpkgs.flake = inputs.nixpkgs;})
      ];

    in {
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well
      nixPath = mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

      optimise.automatic = true;

      # pin the registry to avoid downloading and evaluating a new nixpkgs version every time
      # this will add each flake input as a registry to make nix3 commands consistent with your flake
      registry = mappedRegistry;

      settings = {
        auto-optimise-store = true;
        builders-use-substitutes = true;
        experimental-features = "nix-command flakes";
        log-lines = 50;
        warn-dirty = false;

        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://nixpkgs-unfree.cachix.org"
          "https://numtide.cachix.org"
          "https://helix.cachix.org"
          "https://catppuccin.cachix.org"
          "https://nur.cachix.org"
          "https://nixvim.cachix.org"
          "https://nixpkgs-wayland.cachix.org"
          "https://nix-darwin.cachix.org"
          "https://home-manager.cachix.org"
          "https://lanzaboote.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
          "nur.cachix.org-1:F8+2oprcHLfsYyZBCsVJZJrPyGHwuE+EZBtukwalV7o="
          "nixvim.cachix.org-1:8xrm/43sWNaE3sqFYil49+3wO5LqCbS4FHGhMCuPNNA="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
          "nix-darwin.cachix.org-1:LxMyKzQk7Uqkc1Pfq5uhm9GSn07xkERpy+7cpwc006A="
          "home-manager.cachix.org-1:nx0l4sX9c2ztlU9/RkBtqJZOuk3VFSqZSTf+ijiL1HE="
          "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
        ];

        use-xdg-base-directories = true;
      };
    };
  };
}
