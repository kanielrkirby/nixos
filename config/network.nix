{
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    time.timeZone = "America/Chicago";
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # networking.firewall.enable = false;
    services.openssh.enable = true;
    services.mullvad-vpn.enable = true;
}

