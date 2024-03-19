{
  disko.devices = {
    disk = {
      primary = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            swap = {
              size = "16G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zpool";
              };
            };
          };
        };
      };
    };
    zpool = {
      zpool = {
        type = "zpool";
        datasets = {
          root = {
            type = "zfs_fs";
            options = {
              mountpoint = "/";
              encryption = "aes-256-gcm";
            };
          };
          nix = {
            type = "zfs_fs";
            options.mountpoint = "/nix";
          };
          var = {
            type = "zfs_fs";
            options.mountpoint = "/var";
          };
          home = {
            type = "zfs_fs";
            options.mountpoint = "/home";
          };
          persist = {
            type = "zfs_fs";
            options.mountpoint = "/persist";
          };
        };
      };
    };
  };
}
