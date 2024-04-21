{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.hardware.framework = {
    soundfix.enable = mkOption {
      type = types.bool;
      default = false;
    };
    mousefix.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.hardware.framework.mousefix.enable {
      services.tlp.settings.USB_AUTOSUSPEND = 0;

      services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0032", ATTR{power/autosuspend}="-1"
      '';
    })
    (mkIf config.gearshift.hardware.framework.soundfix.enable {
      home-manager.users."${config.gearshift.username}" = {
        services.easyeffects = {
          enable = true;
          preset = "lappy_mctopface";
        };

        xdg.configFile."easyeffects/output".source = builtins.fetchGit {
          url = "https://github.com/ceiphr/ee-framework-presets";
          rev = "27885fe00c97da7c441358c7ece7846722fd12fa";
        };
      };
    })
  ];
}
