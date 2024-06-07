{ config, lib, pkgs, ... }:

{
  options.gearshift.localsend.enable = lib.mkEnableOption "LocalSend";

  config = lib.mkIf config.gearshift.localsend.enable {
    home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [ localsend ];

    networking.firewall = {
      allowedTCPPorts = [ 53317 ];
      allowedUDPPortRanges = [{
        from = 53315;
        to = 53318;
      }];
    };
  };
}
