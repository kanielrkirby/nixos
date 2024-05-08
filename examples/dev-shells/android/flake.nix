{
  description = "Development environment for Android.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, android-nixpkgs, ... }@inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    android-sdk = android-nixpkgs.sdk.${system} (sdkPkgs: with sdkPkgs; [
      build-tools-34-0-0
      platform-tools
      platforms-android-34
      ndk-26-1-10909125
      emulator
      cmdline-tools-latest
      skiaparser-3
      sources-android-34
    ]
    ++ lib.optionals (system == "aarch64-darwin") [
      system-images-android-34-google-apis-arm64-v8a
      system-images-android-34-google-apis-playstore-arm64-v8a
    ]
    ++ lib.optionals (system == "x86_64-darwin" || system == "x86_64-linux") [
      system-images-android-34-google-apis-x86-64
      system-images-android-34-google-apis-playstore-x86-64
    ]);
  in
  {
    packages = {
      inherit android-sdk;
      android-studio = pkgs.androidStudioPackages.stable;
    };

    devShell = pkgs.mkShell {
      buildInputs = with pkgs; [
        jdk
      ];

      shellHook =
        ''
          export ANDROID_HOME="${android-sdk}/share/android-sdk";
          export ANDROID_SDK_ROOT="${android-sdk}/share/android-sdk";
          export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
          export JAVA_HOME="${pkgs.jdk.home}";
          echo "Android SDK Loaded.";
          echo "$(${android-sdk}/bin/sdkmanager --list)";
          echo "$(${pkgs.jdk}/bin/jdk --version)";
        '';
      };
    });
  }
