{
  system,
  inputs,
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) optionals filterAttrs isType mapAttrs mapAttrsToList mkDefault mkIf pipe;
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
      extraGroups = ["wheel"];
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
        # deploy-rs TODO: Move this to it's own file.
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

        substituters =
          []
          ++ optionals (system == "x86_64-linux" || system == "aarch64-linux") [
            "https://cache.nixos.org"
            "https://home-manager.cachix.org"
          ]
          ++ optionals (system == "x86_64-darwin" || system == "aarch64-darwin") [
            "https://nix-darwin.cachix.org"
          ];

        trusted-public-keys =
          []
          ++ optionals (system == "x86_64-linux" || system == "aarch64-linux") [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "home-manager.cachix.org-1:nx0l4sX9c2ztlU9/RkBtqJZOuk3VFSqZSTf+ijiL1HE="
          ]
          ++ optionals (system == "x86_64-darwin" || system == "aarch64-darwin") [
            "nix-darwin.cachix.org-1:LxMyKzQk7Uqkc1Pfq5uhm9GSn07xkERpy+7cpwc006A="
          ];

        use-xdg-base-directories = true;
      };
    };
  };
}
