{ username, ... }:

{
  virtualisation = { libvirtd = { enable = true; }; };

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
      extraGroups = [ "libvirtd" ];
    };
  };

  programs.virt-manager.enable = true;
}
