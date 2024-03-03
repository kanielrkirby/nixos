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
      forceImportRoot = true;
      extraPools = [ "zpool" ];
    };

    initrd = {
      systemd.enable = true;
      kernelModules = [ "zfs" ];
    };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
