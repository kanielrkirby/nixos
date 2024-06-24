{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.${namespace}.dms.sddm;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs.libsForQt5; [
      qtgraphicaleffects
      qtsvg
      qtquickcontrols
    ];
  };
}
