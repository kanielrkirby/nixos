{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
