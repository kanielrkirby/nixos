{ pkgs, username, ... }:

{
  programs.zsh.enable = true;

  users = { defaultUserShell = pkgs.zsh; };

  home-manager.users."${username}" = {
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
}
