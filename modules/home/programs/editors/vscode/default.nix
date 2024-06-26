{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.programs.editors.vscode;
in {
  options.${namespace}.programs.editors.vscode = {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [asvetliakov.vscode-neovim];
      };
    };
  };
}
