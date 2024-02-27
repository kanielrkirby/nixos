{ username, ... }: 

{
  security.rtkit.enable = true;
  sound.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  home-manager.users."${username}" = {
    services.easyeffects = {
      enable = true;
      preset = "lappy_mctopface";
    };

    xdg.configFile."easyeffects/output".source = builtins.fetchGit {
      url = "https://github.com/ceiphr/ee-framework-presets";
      rev = "27885fe00c97da7c441358c7ece7846722fd12fa";
    };
  };
}
