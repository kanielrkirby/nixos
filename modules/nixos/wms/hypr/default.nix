{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.wms.hypr;
in {
  options.${namespace}.wms.hypr = {
    enable = mkBoolOpt false "Whether or not to enable hypr.";
  };

  config = mkIf cfg.enable {
    ${namespace}.wms.xserver.enable = true;
    services.xserver.displayManager = {
      session = [
        {
          manage = "desktop";
          name = "Hypr";
          start = ''
            ${pkgs.hypr}/bin/hypr &amp;
            waitPID=$!
          '';
        }
      ];
    };
  };
}
