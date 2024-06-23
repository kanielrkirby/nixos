{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.wms.hy3;
in {
  options.${namespace}.wms.hy3 = {
    enable = mkBoolOpt false "Whether or not to enable hy3.";
  };

  config =
    mkIf cfg.enable {
    };
}
