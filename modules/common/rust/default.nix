{ config, lib, pkgs, ... }:

{
  options.gearshift.rust.enable = lib.mkEnableOption "Rust";

  config = lib.mkIf config.gearshift.rust.enable {
    home-manager.users."${config.gearshift.username}" = {
      home.packages = with pkgs; [
      ];
    };
  };
}
