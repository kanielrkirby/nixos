{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.signal;
in {
  options.${namespace}.programs.gui.signal = {
    enable = mkBoolOpt false "Whether or not to enable signal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [signal-desktop];
  };
}
