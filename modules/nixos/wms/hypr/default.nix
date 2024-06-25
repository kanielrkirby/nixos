{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.wms.hypr;
in {
  options.${namespace}.wms.hypr = {
    enable = mkBoolOpt false "Whether or not to enable hypr.";
  };

  config = mkIf cfg.enable {
    ${namespace}.services.xserver = enabled;
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
