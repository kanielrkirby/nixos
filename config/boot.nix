{ pkgs, ... }:

{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
      };
    };

    initrd.systemd.enable = true;

    kernelPackages = pkgs.linuxPackages_6_7;
  };
  
  swapDevices = [
    {
      device = "/dev/nvme0n1p2";
    }
  ];
}
