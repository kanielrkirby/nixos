{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.boot.fs.zfs;
in {
  options.${namespace}.hardware.boot.fs.zfs = {
    enable = mkBoolOpt false "Whether or not to enable ZFS.";
  };

  config = mkIf cfg.enable {
    boot = {
      initrd = {
        kernelModules = ["zfs"];
        systemd.enable = true;
      };

      supportedFilesystems = ["zfs"];

      zfs = {
        forceImportRoot = true;
        extraPools = ["zpool"];
      };

      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        systemd-boot.enable = true;
      };

      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    };
  };
}
