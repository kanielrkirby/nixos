{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkMerge mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.framework;
in {
  options.${namespace}.hardware.framework = {
    enable = mkBoolOpt false "Whether or not to enable all framework fixes.";
    soundfix.enable = mkBoolOpt false "Whether or not to enable framework soundfix.";
    mousefix.enable = mkBoolOpt false "Whether or not to enable framework mousefix.";
    ectool.enable = mkBoolOpt false "Whether or not to enable framework mousefix.";
  };

  config = mkMerge [
    (mkIf (cfg.mousefix.enable || cfg.enable) {
      services = {
        tlp.settings.USB_AUTOSUSPEND = 0;

        udev.extraRules = ''
          ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0032", ATTR{power/autosuspend}="-1"
        '';
      };
    })
    (mkIf (cfg.ectool.enable || cfg.enable) {
      environment.systemPackages = with pkgs; [
        fw-ectool
      ];
    })
  ];
}
