{
  description = "Dev environment for Go.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }@inputs:
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
        dbus
        glib
        go
      ];

      shellHook =
        ''
          echo "$(go version)";
          echo "Environment ready with Golang.";
        '';
      };
    });
  }
