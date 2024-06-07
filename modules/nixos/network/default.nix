{ config, lib, ... }:

with lib;
{
  options.gearshift.network = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
    firewall.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf config.gearshift.network.enable ({
    networking = {
      hostName = config.gearshift.hostName;
      hostId = config.gearshift.hostId;
      networkmanager.enable = true;
      nameservers = [ 
        "194.242.2.2" #dns.mullvad.net
        # 194.242.2.3 #adblock.dns.mullvad.net
        # 194.242.2.4 #base.dns.mullvad.net
        # 194.242.2.5 #extended.dns.mullvad.net
        # 194.242.2.6 #family.dns.mullvad.net
        # 194.242.2.9 #all.dns.mullvad.net
      ];
      firewall = {
        enable = config.gearshift.network.firewall.enable;
        allowedTCPPorts = [
          80 # HTTP
          443 # HTTPS
        ];
        allowedUDPPortRanges = [
          {
            from = 4000;
            to = 4007;
          }
          {
            from = 8000;
            to = 8010;
          }
        ];
      };
    };

    users.users."${config.gearshift.username}".extraGroups = [ "networkmanager" ];

    time.timeZone = config.gearshift.timeZone;
  });
}
