{ pkgs, config, ... }:

{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = { enable = true; };
    };
    supportedFilesystems = [ "zfs" ];

    zfs = {
      forceImportRoot = false;
      extraPools = [ "zprimary" ];
    };

    initrd.systemd.enable = true;

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
