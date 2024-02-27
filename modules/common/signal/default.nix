{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.signal.enable = mkEnableOption "Signal";

  config = mkIf config.gearshift.signal.enable {
    home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
      signal-desktop
      gurk-rs
    ];
  };
}
