{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.alacritty = {
    enable = mkEnableOption "Neovim configuration";
  };

  config = mkIf config.gearshift.alacritty.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.alacritty = {
        enable = true;
        settings = {
          window = { opacity = 0.975; };
        };
      };
    };
  };
}
