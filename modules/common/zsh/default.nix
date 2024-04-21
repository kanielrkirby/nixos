{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.zsh.enable = mkEnableOption "ZSH";

  config = mkIf config.gearshift.zsh.enable {
    programs.zsh.enable = true;

    users = { defaultUserShell = pkgs.zsh; };

    home-manager.users."${config.gearshift.username}" = {
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
      };

      programs.atuin = { enableZshIntegration = true; };

      programs.starship = { enableZshIntegration = true; };

      programs.fzf = { enableZshIntegration = true; };

      programs.zoxide = { enableZshIntegration = true; };
    };
  };
}
