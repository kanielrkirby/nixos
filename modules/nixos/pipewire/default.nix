{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift = {
    pipewire.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.pipewire.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    })
  ];
}
