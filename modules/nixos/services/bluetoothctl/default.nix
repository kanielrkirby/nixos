{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.services.bluetooth.bluetoothctl;
in {
  options.${namespace}.services.bluetooth.bluetoothctl = {
    enable = mkBoolOpt false "Whether or not to enable bluetoothctl.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    hardware.bluetooth = enabled;
    services = {
      bluez = enabled;
      blueman = enabled;
    };
  };
}
