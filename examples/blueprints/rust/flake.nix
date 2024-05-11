{
  description = "Dev environment for Rust.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, fenix, ... }@inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    devShell = pkgs.mkShell {
      buildInputs = with pkgs; [
        gnumake
        gcc
        curl
        wget
        file
        pkg-config
        dbus
        openssl
        glib
        trunk
        evcxr
        clippy
        bacon
        (with fenix.packages.${system}; combine [
          latest.toolchain
        ])
      ];

      shellHook =
        ''
          echo "$(rustc --version)";
          echo "Environment ready with Rust."; 
        '';
      };
    });
  }
