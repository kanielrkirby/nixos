{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.hardware.brightness;
in {
  options.${namespace}.hardware.brightness = {
    enable = mkBoolOpt false "Whether or not to enable brightnessctl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [brightnessctl];
  };
}
