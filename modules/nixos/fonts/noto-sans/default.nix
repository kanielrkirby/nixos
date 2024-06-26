{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.fonts.noto-sans;
in {
  options.${namespace}.fonts.noto-sans = {
    enable = mkBoolOpt false "Whether or not to enable noto-sans.";
  };

  config = mkIf cfg.enable {
    home-manager = {
      users."${config.${namespace}.user.name}" = {
        gtk = {
          font = {
            name = "Noto Sans";
            size = 14;
          };
        };

        programs.fuzzel = {
          settings = { main = { font = "Noto Sans:weight=medium:size=16"; }; };
        };

        services.mako = { font = "Noto Sans 10"; };
      };
    };
  };
}
