{
  inputs,
  system,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (inputs) arbtt;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.arbtt;
in {
  options.${namespace}.programs.terminal.tools.arbtt = {
    enable = mkBoolOpt false "Whether or not to enable arbtt.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    services.arbtt = {
      enable = true;
      package = arbtt.packages.${system}.default;
      logFile = "/home/${config.${namespace}.user.enable}/Documents/notebook/arbtt-capture.log";
    };
  };
}
