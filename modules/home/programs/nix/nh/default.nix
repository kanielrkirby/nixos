{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.nix.nh;
in {
  options.${namespace}.programs.nix.nh = {
    enable = mkBoolOpt false "Whether or not to enable nh.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nh];
  };
}
