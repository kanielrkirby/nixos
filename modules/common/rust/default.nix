{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.rust.enable = mkEnableOption "Rust";

  config = mkIf config.gearshift.rust.enable {
    home-manager.users."${config.gearshift.username}" = {
      home.packages = with pkgs; [
      ];
    };
  };
}
