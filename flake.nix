{
  description = "My NixOS configuration";

  inputs = {
    nixos-pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos-pkgs";
    hyprland.url = "github:hyprwm/Hyprland/main";
    hyprland.inputs.nixpkgs.follows = "nixos-pkgs";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixos-pkgs";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixos-pkgs, impermanence, ... }@inputs: {
    nixosConfigurations = let
      system = "x86_64-linux";
      # kernel = "6_7"; # Commented out for ZFS to handle it
      version = "24.05";
      hostName = "nixos";
      username = "mx";
      locale = "en_US.UTF-8";
      kbLayout = "us";
      timeZone = "America/Chicago";
      wallpaperGit = "https://github.com/Gingeh/wallpapers";
      wallpaperDir = "/home/${username}/.config/wallpapers";
      wallpaperSubDir = "/home/${username}/.config/wallpapers/wallpapers/other";
      pkgs = import nixos-pkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          # Temporary fix until https://github.com/NixOS/nixpkgs/issues/298043 is resolved
          (self: prev: {
            pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
              (python-final: python-prev: {
                catppuccin = python-prev.catppuccin.overridePythonAttrs
                  (oldAttrs: rec {
                    version = "1.3.2";

                    src = prev.fetchFromGitHub {
                      owner = "catppuccin";
                      repo = "python";
                      rev = "refs/tags/v${version}";
                      hash =
                        "sha256-spPZdQ+x3isyeBXZ/J2QE6zNhyHRfyRQGiHreuXzzik=";
                    };

                    # can be removed next version
                    disabledTestPaths = [
                      "tests/test_flavour.py" # would download a json to check correctness of flavours
                    ];
                  });
              })
            ];
          })
        ];
      };
    in {
      default = nixos-pkgs.lib.nixosSystem {
        specialArgs = {
          inherit self;
          inherit system;
          # inherit kernel; # for ZFS
          inherit version;
          inherit inputs;
          inherit hostName;
          inherit username;
          inherit timeZone;
          inherit locale;
          inherit kbLayout;
          inherit wallpaperDir;
          inherit wallpaperSubDir;
          inherit wallpaperGit;
          inherit pkgs;
          inherit impermanence;
        };
        modules = [
          ./config/impermanence.nix
          ./config/hardware/sound.nix
          ./config/hardware/opengl.nix
          ./config/hardware/power.nix
          ./hardware-configuration.nix
          ./config/nixos.nix
          ./config/boot
          ./config/home.nix
          ./config/hyprland
          ./config/nixvim
          ./config/network.nix
          ./config/virt
          # ./config/hyprpaper.nix
          ./config/programs/nixos-programs.nix
          ./config/theme/color.nix
          ./config/theme/gtk.nix
          ./config/theme/qt.nix
          ./config/theme/font.nix
          ./config/sddm.nix
          ./config/user.nix
        ];
      };
    };
  };
}
