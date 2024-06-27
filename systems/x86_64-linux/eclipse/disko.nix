{ # Unused, because Disko doesn't support dual booting
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            efi = {
              size = "1024M";
              type = "EF00";
              name = "efi";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mountpoint = "/";
        rootFsOptions = {
          encryption = "on";
          keyformat = "passphrase";
          keylocation = "prompt";
          compression = "on";
          xattr = "sa";
          acltype = "posixacl";
        };
        options = {
          ashift = 12;
        };
        datasets = {
          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          home = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          var = {
            type = "zfs_fs";
            mountpoint = "/var";
          };
        };
      };
    };
  };
}
