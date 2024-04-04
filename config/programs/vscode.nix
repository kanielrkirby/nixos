{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.vscode = {
      enable = true;
#      extensions = with pkgs.vscode-extensions; [ vscodevim.vim ];
    };
  };
}

