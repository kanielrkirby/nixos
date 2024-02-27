{ username, pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;

  services.spice-vdagentd.enable = true;

  home-manager.users."${username}" = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };

  users = {
    users."${username}" = {
      extraGroups = [ "libvirtd" "kvm" "qemu" "spice" ];
    };
  };

  environment.systemPackages = with pkgs; [ spice-gtk ];

  # set group ownership over the device /dev/bus/usb to "spice"
}
