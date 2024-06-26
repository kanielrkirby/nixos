{
  description = "Gearshift";

  inputs = {
    anyrun = {
      url = "github:anyrun-org/anyrun";
    };

    anyrun-nixos-options = {
      url = "github:n3oney/anyrun-nixos-options";
    };

    catppuccin-cursors = {
      url = "github:catppuccin/cursors";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
    };

    # macos support (master)
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # system deployment
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # gpg default configuration
    gpg-base-conf = {
      url = "github:drduh/config";
      flake = false;
    };

    # home manager (master)
    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "git+file:///home/mx/documents/github/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hypridle
    hypridle.url = "github:hyprwm/hypridle";
    # url = "git+file:///home/mx/documents/github/hypridle";

    # hyprlock
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      # note: required to prevent red screen on lock
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland
    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1";
    };

    # hyprpaper
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
    };

    # hyprland user contributions flake
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
    };

    # hyprland plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # weekly updating nix-index database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs (nixos-unstable)
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # nixpkgs-wayland
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos wsl support
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # run unpatched dynamically compiled binaries
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim nix configuration
    nixvim = {
      url = "github:nix-community/nixvim";
      # url = "git+file:///users/mx/documents/github/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix user repository (master)
    nur = {
      url = "github:nix-community/nur";
    };

    # snowfall lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # snowfall flake
    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops (secrets)
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    waybar = {
      url = "github:alexays/waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # yubikey guide
    yubikey-guide = {
      url = "github:drduh/yubikey-guide";
      flake = false;
    };
  };

  outputs = inputs: let
    inherit (inputs) snowfall-lib;

    lib = snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "gearshift";
          title = "Gearshift";
        };

        namespace = "gearshift";
      };
    };
  in
    lib.mkFlake {
      channels-config = {
        # allowBroken = true;
        allowUnfree = true;
      };

      overlays = with inputs; [
        nix-ld-rs.overlays.default
        nur.overlay
      ];

      homes.modules = with inputs; [
        anyrun.homeManagerModules.default
        catppuccin.homeManagerModules.catppuccin
        hypr-socket-watch.homeManagerModules.default
        nix-index-database.hmModules.nix-index
        nixvim.homeManagerModules.nixvim
        sops-nix.homeManagerModules.sops
      ];

      systems = {
        modules = {
          nixos = with inputs; [
            lanzaboote.nixosModules.lanzaboote
            sops-nix.nixosModules.sops
          ];
        };
      };

      templates = {
      };

      deploy = lib.mkDeploy {inherit (inputs) self;};

      outputs-builder = channels: {formatter = channels.nixpkgs.nixfmt-rfc-style;};
    };
}
