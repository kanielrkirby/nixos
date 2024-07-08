{
  description = "Gearshift";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
    };

    helix = {
      url = "github:helix-editor/helix";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # disko = {
    #   url = "github:nix-community/disko";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # deploy-rs = {
    #   url = "github:serokell/deploy-rs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprlock = {
    #   url = "github:hyprwm/hyprlock";
    # };

    # hyprland = {
    #   url = "git+https://github.com/hyprwm/hyprland?submodules=1";
    # };

    # hyprpaper = {
    #   url = "github:hyprwm/hyprpaper";
    # };

    # hyprland-contrib = {
    #   url = "github:hyprwm/contrib";
    # };

    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.3.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixpkgs-wayland = {
    #   url = "github:nix-community/nixpkgs-wayland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nix-ld-rs = {
    #   url = "github:nix-community/nix-ld-rs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixvim = {
      # url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nur = {
      # url = "github:nix-community/nur";
    # };

    # waybar = {
    #   url = "github:alexays/waybar";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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

      # overlays = with inputs; [
        # nix-ld-rs.overlays.default
        # nur.overlay
      # ];

      systems = {
        modules = {
          nixos = with inputs; [
            sops-nix.nixosModules.sops
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            # lanzaboote.nixosModules.lanzaboote
            # disko.nixosModules.disko
          ];
        };
      };
    };
}
