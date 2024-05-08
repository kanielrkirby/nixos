{
  description = "Dev environment for Tauri, Android, and Leptos.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, fenix, android-nixpkgs, ... }@inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    android-sdk = android-nixpkgs.sdk.${system} (sdkPkgs: with sdkPkgs; [
      cmdline-tools-latest
      build-tools-34-0-0
      platform-tools
      platforms-android-34
      ndk-26-1-10909125
    ]);
  in
  {
    packages = {
      inherit android-sdk;
      android-studio = pkgs.androidStudioPackages.stable;
    };

    devShell = pkgs.mkShell {
      buildInputs = with pkgs; [
        webkitgtk_4_1
        gnumake
        gcc
        curl
        wget
        file
        librsvg
        pkg-config
        dbus
        openssl
        glib
        gtk4
        libsoup
        libappindicator
        trunk
        android-studio
        jdk
        (with fenix.packages.${system}; combine [
          latest.rustc
          latest.cargo
          latest.rust-analyzer
          targets.wasm32-unknown-unknown.latest.rust-std
          targets.aarch64-linux-android.latest.rust-std
          targets.armv7-linux-androideabi.latest.rust-std
          targets.i686-linux-android.latest.rust-std
          targets.x86_64-linux-android.latest.rust-std
        ])
      ];

      shellHook =
        ''
          export ANDROID_HOME="${android-sdk}/share/android-sdk";
          export ANDROID_SDK_ROOT="${android-sdk}/share/android-sdk";
          export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
          export JAVA_HOME="${pkgs.jdk.home}";
          echo "$(rustc --version)"
          echo "$(cargo tauri --version)"
          echo "$(sdkmanager --list)"
          echo "Environment ready with Android SDK, Rust Nightly, and Tauri.";
        '';
      };
    });
  }
