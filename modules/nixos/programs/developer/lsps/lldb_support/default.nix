{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.developer.lsps.lldb_support;
in {
  options.${namespace}.programs.developer.lsps.lldb_support = {
    enable = mkBoolOpt false "Whether or not to enable the lldb_support.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [yaml-language-server];
  };
}
