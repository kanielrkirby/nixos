{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.localsend;
in {
  options.${namespace}.programs.gui.localsend = {
    enable = mkBoolOpt false "Whether or not to enable localsend.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [localsend];

    networking.firewall = {
      allowedTCPPorts = [53317];
      allowedUDPPortRanges = [
        {
          from = 53315;
          to = 53318;
        }
      ];
    };
  };
}
