{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.protobuf.bufls;
in {
  options.${namespace}.programs.developer.lsps.protobuf.bufls = {
    enable = mkBoolOpt false "Whether or not to enable the bufls.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [buf-language-server];
  };
}
