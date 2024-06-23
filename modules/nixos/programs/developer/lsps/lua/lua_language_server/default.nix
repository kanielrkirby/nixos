{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.lua.lua_language_server;
in {
  options.${namespace}.programs.developer.lsps.lua.lua_language_server = {
    enable = mkBoolOpt false "Whether or not to enable the lua_language_server.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [lua-language-server];
  };
}
