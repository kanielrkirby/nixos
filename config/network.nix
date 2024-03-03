{ hostName, timeZone, ... }:

{
  networking = {
    hostName = hostName;
    hostId = "3759be58";
    networkmanager.enable = true;
    # mx is added to the networkmanager group in ./home.nix
    nameservers = [ "9.9.9.9" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80 # HTTP
        443 # HTTPS
        53317 # LocalSend
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
        {
          from = 53315;
          to = 53318;
        } # LocalSend
      ];
    };
  };

  time.timeZone = timeZone;
  services.openssh.enable = true;
  services.mullvad-vpn.enable = true;
}

