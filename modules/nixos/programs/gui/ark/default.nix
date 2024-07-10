{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.ark;
in {
  options.${namespace}.programs.gui.ark = {
    enable = mkBoolOpt false "Whether or not to enable ark.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ark];
  };
}
