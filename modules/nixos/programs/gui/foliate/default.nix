{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.foliate;
in {
  options.${namespace}.programs.gui.foliate = {
    enable = mkBoolOpt false "Whether or not to enable foliate.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      foliate
    ];
  };
}
