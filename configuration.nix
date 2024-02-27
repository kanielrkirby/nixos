# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./config/hardware-configuration.nix
      ./config/hardware.nix
      ./config/packages.nix
      ./config/home.nix
      ./config/services.nix
      ./config/boot.nix
      ./config/network.nix
    ];

  i18n.defaultLocale = "en_US.UTF-8";

  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11";
}

