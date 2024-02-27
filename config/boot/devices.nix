{ config, ... }:

{
  boot = {
    supportedFilesystems = [ "zfs" ];

    zfs = {
      forceImportRoot = true;
      extraPools = [ "zpool" ];
    };

    initrd = { kernelModules = [ "zfs" ]; };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
