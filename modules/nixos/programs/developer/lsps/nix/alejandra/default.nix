{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.nix.alejandra;
in {
  options.${namespace}.programs.developer.lsps.nix.alejandra = {
    enable = mkBoolOpt false "Whether or not to enable the alejandra.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [alejandra];
  };
}
