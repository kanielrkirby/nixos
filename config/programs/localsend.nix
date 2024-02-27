{ username, pkgs, ... }:

{
  home-manager.users."${username}".home.packages = with pkgs; [ localsend ];

  networking.firewall = {
    allowedTCPPorts = [ 53317 ];
    allowedUDPPortRanges = [{
      from = 53315;
      to = 53318;
    }];
  };
}
