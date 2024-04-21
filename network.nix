{ hostName, timeZone, username, ... }:

{
  networking = {
    hostName = hostName;
    hostId = "3759be58";
    networkmanager.enable = true;
    nameservers = [ "9.9.9.9" "1.1.1.1" "8.8.8.8" ]; # Quad9, Cloudflare, Google
    firewall = {
      enable = true;
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

  users.users."${username}".extraGroups = [ "networkmanager" ];

  time.timeZone = timeZone;
}

