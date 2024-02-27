{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.vscode.enable = mkEnableOption "VSCode";

  config = mkIf config.gearshift.vscode.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.vscode = {
        enable = true;
#      extensions = with pkgs.vscode-extensions; [ vscodevim.vim ];
      };
    };
  };
}
