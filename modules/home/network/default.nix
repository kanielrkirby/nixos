{
  config,
  lib,
  namespace,
  host,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username enabled;

  cfg = config.${namespace}.network;
in {
  options.${namespace}.network = {
    enable = mkBoolOpt false "Whether or not to set the default network settings.";
    firewall = mkBoolOpt false "Whether or not to enable firewall.";
    dns = {
      mullvad-default.enable = mkBoolOpt true "Whether or not to add the 'default' mullvad DNS.";
      mullvad-adblock.enable = mkBoolOpt false "Whether or not to add the 'adblock' mullvad DNS.";
      mullvad-base.enable = mkBoolOpt false "Whether or not to add the 'base' mullvad DNS.";
      mullvad-family.enable = mkBoolOpt false "Whether or not to add the 'family' mullvad DNS.";
      mullvad-extended.enable = mkBoolOpt false "Whether or not to add the 'extended' mullvad DNS.";
      mullvad-all.enable = mkBoolOpt false "Whether or not to add the 'all' mullvad DNS.";
    };
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = host;
      networkmanager = enabled;
      nameservers = [
        (lib.optionals cfg.dns.mullvad-default "194.242.2.2")
        (lib.optionals cfg.dns.mullvad-adblock "194.242.2.3")
        (lib.optionals cfg.dns.mullvad-base "194.242.2.4")
        (lib.optionals cfg.dns.mullvad-family "194.242.2.5")
        (lib.optionals cfg.dns.mullvad-extended "194.242.2.6")
        (lib.optionals cfg.dns.mullvad-all "194.242.2.9")
      ];
      firewall = lib.optionals config.gearshift.network.firewall.enable {
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

    users.users."${username}".extraGroups = ["networkmanager"];

    time.timeZone = "America/Chicago";
  };
}
