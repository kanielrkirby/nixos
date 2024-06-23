{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.virtualization.libvirt;
in {
  options.${namespace}.programs.developer.virtualization.libvirt = {
    enable = mkBoolOpt false "Whether or not to enable libvirt.";
  };

  config = mkMerge [
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      virtualisation = {
        libvirtd = {
          enable = true;
        };
        spiceUSBRedirection.enable = true;
      };
      programs.virt-manager.enable = true;

      services.spice-vdagentd.enable = true;

      users = {
        users."${config.${namespace}.user.name}" = {
          extraGroups = ["libvirtd" "kvm" "qemu" "spice"];
        };
      };

      environment.systemPackages = with pkgs; [spice-gtk];
      home-manager.users.${config.${namespace}.user.name} = {
        dconf.settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
          };
        };
      };
    })
  ];
}
