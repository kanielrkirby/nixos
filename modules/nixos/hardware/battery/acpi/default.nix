{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.battery.acpi;
in {
  options.${namespace}.hardware.battery.acpi = {
    enable = mkBoolOpt false "Whether or not to enable acpi.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [acpi];
  };
}
