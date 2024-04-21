{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift = {
    libvirt.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.libvirt.enable {
      virtualisation = {
        libvirtd = {
          enable = true;
        };
        spiceUSBRedirection.enable = true;
      };
      programs.virt-manager.enable = true;

      services.spice-vdagentd.enable = true;

      home-manager.users."${config.gearshift.username}" = {
        dconf.settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = [ "qemu:///system" ];
            uris = [ "qemu:///system" ];
          };
        };
      };

      users = {
        users."${config.gearshift.username}" = {
          extraGroups = [ "libvirtd" "kvm" "qemu" "spice" ];
        };
      };

      environment.systemPackages = with pkgs; [ spice-gtk ];
    })
  ];
}
