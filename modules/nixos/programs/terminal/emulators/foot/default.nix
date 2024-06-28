{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.foot;
in {
  options.${namespace}.programs.terminal.emulators.foot = {
    enable = mkBoolOpt false "Whether or not to enable foot.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "MonaspiceNe NF:size=10";
          font-italic = "MonaspiceRn NF:size=10";
          dpi-aware = "yes";
        };

        colors.alpha = "0.8";

        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
