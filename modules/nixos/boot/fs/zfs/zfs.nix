{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift = {
    zfs = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      rollback.enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkMerge [
    ({
      assertions = [
        {
          assertion = !(config.gearshift.zfs.enable && config.gearshift.ext4.enable);
          message = "Only one of ZFS or EXT4 as the primary system FS may be selected.";
        }
        {
          assertion = (config.gearshift.zfs.enable || config.gearshift.ext4.enable);
          message = "At least one of either EXT4 or ZFS must be selected.";
        }
      ];
    })
    (mkIf config.gearshift.zfs.enable {
      boot = {
        initrd = {
          kernelModules = [ "zfs" ];
          systemd.enable = true;
        };

        supportedFilesystems = [ "zfs" ];

        zfs = {
          forceImportRoot = true;
          extraPools = [ "zpool" ];
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
    })

    (mkIf config.gearshift.zfs.rollback.enable {
      systemd.services.rollback = {
        description = "Rollback";
        wantedBy = [ "initrd.target" ];
        after = [ "zfs-import-zpool.service" ];
        before = [ "sysroot.mount" ];
        path = with pkgs; [ zfs ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          zfs rollback -r zpool/root@blank
#          zfs rollback -r zpool/nix@blank
          zfs rollback -r zpool/var@blank
          zfs rollback -r zpool/home@blank
          echo "Rollback completed"
          return 0
        '';
      };
      systemd.services.auto-upgrade-system = {
        description = "Auto-Rebuild";
        wantedBy = [ "multi-user.target" ];
        after = [ "rollback.service" ];
        path = with pkgs; [ zfs ];
        serviceConfig.Type = "oneshot";
        script = ''
          echo "Attempting rebuild"
          nixos-rebuild switch --flake /etc/nixos#nixos
          echo "Complete rebuild"
          return 0
        '';
      };
    })
  ];
}
