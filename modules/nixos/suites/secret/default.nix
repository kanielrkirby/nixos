{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.suite.secret = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.suite.secret.enable {
      gearshift.gnupg.enable = true;
      gearshift.ssh.enable = true;
      gearshift.sops.enable = true;
      gearshift.password-store.enable = true;
      gearshift.mullvad-vpn.enable = true;
    })
  ];
}
