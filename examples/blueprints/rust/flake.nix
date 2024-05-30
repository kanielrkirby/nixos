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
    rust-mixed = (with fenix.packages.${system}; combine [
      latest.toolchain
      targets.wasm32-unknown-unknown.latest.toolchain
    ]);
  in
  {
    devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          openssl
          pkg-config
          cacert
          cargo-make
          cargo-whatfeatures
          sass
          tailwindcss
          mold
          sccache
          evcxr
          bacon
          trunk
          rust-mixed
        ];

        shellHook = ''
          function heading() {
            echo;
            echo "$@";
            echo;
          }

          function indent() {
            echo "$@" | sed 's/^.*/  \0/';
          }

          echo "$(
            heading "Installed Targets:";
            indent "$(
              ls ${rust-mixed}/lib/rustlib | grep -v "src\|etc"
            )"
          )";

          echo "$(
            heading "Environment Packages:";
            indent "$(
              cargo --version | sed 's/ (.*$//';
              trunk --version;
              evcxr --version;
              bacon --version;
              sccache --version;
              cargo make --version;
              cargo whatfeatures --version;
              echo "pkg-config $(pkg-config --version)";
              mold --version | sed 's/ (.*$//';
              sass --version;
              tailwindcss --help | head -n 2 | tail -n 1;
              openssl version | sed 's/\([^ ]* [^ ]*\).*/\1/';
            )";
          )";

          echo;
        '';
      };
    });
  }
