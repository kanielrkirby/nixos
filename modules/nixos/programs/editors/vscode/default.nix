{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.editors.vscode;
in {
  options.${namespace}.programs.editors.vscode = {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.name != null) {
    snowfallorg.users.${config.${namespace}.user.name}.programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [asvetliakov.vscode-neovim];
    };
  };
}
