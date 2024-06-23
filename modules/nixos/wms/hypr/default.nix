{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.wms.hypr;
in {
  options.${namespace}.wms.hypr = {
    enable = mkBoolOpt false "Whether or not to enable hypr.";
  };

  config = mkIf cfg.enable {
    ${namespace}.wms.xserver.enable = true;
    home-manager.users."${config.gearshift.username}" = {
      home.packages = with pkgs; [hypr];
      xdg.configFile."hypr/hypr.conf".text = builtins.concatStringsSep "\n" (builtins.map builtins.readFile [./binds.conf ./hypr.conf]);
    };
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
