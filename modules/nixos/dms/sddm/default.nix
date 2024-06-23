{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.dms.sddm;
in {
  options.${namespace}.dms.sddm = {
    enable = mkBoolOpt false "Whether or not to enable sddm.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}".home.packages = with pkgs.libsForQt5; [
      qtgraphicaleffects
      qtsvg
      qtquickcontrols
    ];

    services.xserver.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
