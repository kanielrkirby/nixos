{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.hardware.bluetooth;
in {
  options.${namespace}.hardware.bluetooth = {
    enable = mkBoolOpt false "Whether or not to enable default bluetooth settings.";
    hardware.enable = mkBoolOpt false "Whether or not to enable bluetooth at a hardware level.";
    bluez.enable = mkBoolOpt false "Whether or not to enable bluez.";
    blueman.enable = mkBoolOpt false "Whether or not to enable blueman.";
  };

  config = mkMerge [
    (mkIf (cfg.enable || cfg.hardware.enable) {
      hardware.bluetooth = enabled;
    })
    (mkIf (cfg.enable || cfg.blueman.enable) {
      services = {
        blueman = enabled;
      };
    })
    (mkIf (cfg.enable || cfg.bluez.enable) {
      environment.systemPackages = with pkgs; [bluez];
    })
  ];
}
