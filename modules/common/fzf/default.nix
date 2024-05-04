{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.fzf.enable = mkEnableOption "FZF";

  config = mkIf config.gearshift.fzf.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.fzf = {
        enable = true;
        enableZshIntegration = config.home-manager.users."${config.gearshift.username}".programs.zsh.enable;
      };
    };
  };
}
