{ pkgs, ... }:

# This setup heavily relies on ZFS at the moment, so please makes sure that that is properly set up before enabling this file.
{
  boot = {
    initrd = {
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
    };
  };
}
