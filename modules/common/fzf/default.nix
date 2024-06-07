{ config, lib, ... }:

{
  options.gearshift.fzf.enable = lib.mkEnableOption "FZF";

  config = lib.mkIf config.gearshift.fzf.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.fzf = {
        enable = true;
        enableZshIntegration = config.home-manager.users."${config.gearshift.username}".programs.zsh.enable;
      };
    };
  };
}
