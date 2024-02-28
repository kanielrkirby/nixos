{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd = {
      enable = true;
    };
  };

  programs.virt-manager.enable = true;

  home-manager.users.mx.dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # mx is added it "libvirtd" group in ./home.nix
}
