{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.virtualization.vagrant;
in {
  options.${namespace}.programs.developer.virtualization.vagrant = {
    enable = mkBoolOpt false "Whether or not to enable vagrant.";
  };

  config = mkIf cfg.enable {
    ${namespace}.programs.developer.virtualization.libvirt.enable = true;

    services.nfs = { server.enable = true; };
    # Add firewall exception for VirtualBox provider 
    networking.firewall.extraCommands = ''
      iptables -I INPUT 1 -i virbr0 -p tcp -m tcp --dport 2049 -j ACCEPT
    '';
  
    environment.systemPackages = with pkgs; [ vagrant ];
  
    # Add firewall exception for libvirt provider when using NFSv4 
    networking.firewall.interfaces."virbr1" = {
      allowedTCPPorts = [ 2049 ];
      allowedUDPPorts = [ 2049 ];
    };
  };
}
