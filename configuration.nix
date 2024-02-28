# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./config/nixos.nix
      ./hardware-configuration.nix
      ./config/boot.nix
      ./config/hardware.nix
      ./config/packages.nix
      ./config/home.nix
      ./config/desktop-environment.nix
      ./config/nixvim.nix
      ./config/network.nix
      ./config/virtualization.nix
    ];
}

