{
  config.gearshift = {
    hardware = {
      sound = {
        enable = true;
      };
      intel.enable = true;
      framework = {
        mousefix.enable = true;
        soundfix.enable = true;
      };
      powersaving.enable = true;
    };

    suite = {
      home.enable = true;
      dev.enable = true;
      secret.enable = true;
      virt.enable = true;
      theme.enable = true;
    };

    wm.hypr = {
      enable = true;
      wayland.enable = true;
    };

    dm.greetd.enable = true;

    lock.hyprlock.enable = true;

    zfs.enable = true;
  };
}
