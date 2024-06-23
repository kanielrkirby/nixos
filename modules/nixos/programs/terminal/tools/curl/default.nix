{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.curl;
in {
  options.${namespace}.programs.terminal.tools.curl = {
    enable = mkBoolOpt false "Whether or not to enable curl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      curl
    ];
  };
}
