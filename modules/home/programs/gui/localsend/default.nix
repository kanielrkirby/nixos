{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.programs.network.localsend;
in {
  options.${namespace}.programs.network.localsend = {
    enable = mkBoolOpt false "Whether or not to enable localsend.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}".home.packages = with pkgs; [localsend];

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
