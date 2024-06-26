{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.wms.xserver;
in {
  options.${namespace}.wms.xserver = {
    enable = mkBoolOpt false "Whether or not to enable i3.";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb.layout = config.gearshift.kb-layout;
      libinput.enable = true;
      videoDrivers = ["modesetting"];
    };
  };
}
