{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.suite.virt = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.suite.virt.enable {
      gearshift.libvirt.enable = true;
      gearshift.vagrant.enable = true;
      gearshift.k8s.enable = true;
      gearshift.podman.enable = true;
    })
  ];
}
