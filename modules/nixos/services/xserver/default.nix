{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.xserver;
in {
  options.${namespace}.services.xserver = {
    enable = mkBoolOpt false "Whether or not to enable i3.";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      libinput.enable = true;
      videoDrivers = ["modesetting"];
    };
  };
}
