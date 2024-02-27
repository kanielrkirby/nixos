{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = { enable = true; };
    };

    initrd = {
      systemd.enable = true;
    };
  };
}
