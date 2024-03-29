{ username, pkgs, ... }:

{
  services.nfs = { server.enable = true; };
  # Add firewall exception for VirtualBox provider 
  networking.firewall.extraCommands = ''
    iptables -I INPUT 1 -i virbr0 -p tcp -m tcp --dport 2049 -j ACCEPT
  '';

  home-manager.users."${username}".home.packages = with pkgs; [ vagrant ];

  # Add firewall exception for libvirt provider when using NFSv4 
  networking.firewall.interfaces."virbr1" = {
    allowedTCPPorts = [ 2049 ];
    allowedUDPPorts = [ 2049 ];
  };
}
