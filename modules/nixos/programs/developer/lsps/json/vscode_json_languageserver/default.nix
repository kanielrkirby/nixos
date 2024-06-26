{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.json.vscode_json_languageserver;
in {
  options.${namespace}.programs.developer.lsps.json.vscode_json_languageserver = {
    enable = mkBoolOpt false "Whether or not to enable the vscode_json_languageserver.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nodePackages_latest.vscode-json-languageserver];
  };
}
