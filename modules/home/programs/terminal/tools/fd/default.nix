{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.fd;
in {
  options.${namespace}.programs.terminal.tools.fd = {
    enable = mkBoolOpt false "Whether or not to enable fd.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fd
    ];
  };
}
