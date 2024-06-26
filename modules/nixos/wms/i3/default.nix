{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.wms.i3;
in {
  options.${namespace}.wms.i3 = {
    enable = mkBoolOpt false "Whether or not to enable i3.";
  };

  config = mkIf cfg.enable {
    ${namespace}.wms.xserver.enable = true;
    services = {
      xserver = {
        desktopManager.xterm.enable = false;
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
            i3lock
          ];
        };
        displayManager = {
          session = [
            {
              manage = "window";
              name = "i3";
              start = ''
                ${pkgs.i3}/bin/i3 &amp;
                waitPID=$!
              '';
            }
          ];
        };
      };
    };
  };
}
