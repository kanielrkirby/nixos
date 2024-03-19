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

  fileSystems = {
    "/" = {
      device = "zpool/root";
      fsType = "zfs";
      neededForBoot = true;
    };

    "/nix" = {
      device = "zpool/nix";
      fsType = "zfs";
      neededForBoot = true;
    };

    "/var" = {
      device = "zpool/var";
      fsType = "zfs";
    };

    "/home" = {
      device = "zpool/home";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/nvme0n1p3";
      fsType = "vfat";
      neededForBoot = true;
    };
  };
  swapDevices = [{ device = "/dev/nvme0n1p2"; }];
}
