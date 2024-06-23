{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.httpie;
in {
  options.${namespace}.programs.terminal.tools.httpie = {
    enable = mkBoolOpt false "Whether or not to enable httpie.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      httpie
    ];
  };
}
