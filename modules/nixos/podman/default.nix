{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift = {
    podman.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.podman.enable {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };
    })
  ];
}
