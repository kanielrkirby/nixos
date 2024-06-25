{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.dms.sddm;
in {
  options.${namespace}.dms.sddm = {
    enable = mkBoolOpt false "Whether or not to enable SDDM.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs.libsForQt5; [
      qtgraphicaleffects
      qtsvg
      qtquickcontrols
    ];
  };
}
