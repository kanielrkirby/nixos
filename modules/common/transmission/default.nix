{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.transmission.enable = mkEnableOption "Transmission";

  config = mkIf config.gearshift.transmission.enable {
    environment.systemPackages = with pkgs; [ transmission_4-gtk ];
  };
}
