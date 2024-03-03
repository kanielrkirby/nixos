{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd = { enable = true; };
  };

  programs.virt-manager.enable = true;

  # mx.dconf settings are in ./home-manager.nix

  # mx is added to "libvirtd" group in ./home-manager.nix
}
