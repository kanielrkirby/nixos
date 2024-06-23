{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.virtualization.libvirt;
in {
  options.${namespace}.programs.developer.virtualization.libvirt = {
    enable = mkBoolOpt false "Whether or not to enable libvirt.";
  };

  config = mkIf cfg.enable {
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
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };

    users = {
      users."${config.gearshift.username}" = {
        extraGroups = ["libvirtd" "kvm" "qemu" "spice"];
      };
    };

    environment.systemPackages = with pkgs; [spice-gtk];
  };
}
