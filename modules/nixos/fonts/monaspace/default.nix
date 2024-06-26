{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.fonts.monaspace;
in {
  options.${namespace}.fonts.monaspace = {
    enable = mkBoolOpt false "Whether or not to enable monaspace.";
  };

    config = mkIf cfg.enable {
      fonts.packages = with pkgs;
        [ (nerdfonts.override { fonts = [ "Monaspace" ]; }) ];
    };
}
