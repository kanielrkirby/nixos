{ hostName, timeZone, ... }:

{
    networking.hostName = hostName;
    networking.networkmanager.enable = true;
    # mx is added to the networkmanager group in ./home.nix
    time.timeZone = timeZone;
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    networking = {
      nameservers = [ "9.9.9.9" ];
      firewall = {
        enable = true;
        allowedTCPPorts = [
          80 # HTTP
          443 # HTTPS
          53317 # LocalSend
        ];
        allowedUDPPortRanges = [
          { from = 4000; to = 4007; }
          { from = 8000; to = 8010; }
          { from = 53315; to = 53318; } # LocalSend
        ];
      };
    };
    services.openssh.enable = true;
    services.mullvad-vpn.enable = true;
}

