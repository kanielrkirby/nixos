{ config, lib, ... }:

with lib;
{
  options.gearshift.eza.enable = mkEnableOption "Eza";

  config = mkIf config.gearshift.eza.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = true;
      };
    };
  };
}
