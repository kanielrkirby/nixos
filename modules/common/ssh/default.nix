{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.ssh.enable = mkEnableOption "SSH";

  config = mkIf config.gearshift.ssh.enable {
    services.openssh.enable = true;
  };
}
