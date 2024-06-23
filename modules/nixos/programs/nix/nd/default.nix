{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.nix.nd;
in {
  options.${namespace}.programs.nix.nd = {
    enable = mkBoolOpt false "Whether or not to enable nd.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "nd" ''
        nix develop path:. -c "${zsh}/bin/zsh" $@;
      '')
    ];
  };
}
