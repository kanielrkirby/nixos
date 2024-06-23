{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.gui.fuzzel;
in {
  options.${namespace}.programs.gui.fuzzel = {
    enable = mkBoolOpt false "Whether or not to enable fuzzel.";
  };

  config = mkIf cfg.enable {
    programs.fuzzel = enabled;
  };
}
