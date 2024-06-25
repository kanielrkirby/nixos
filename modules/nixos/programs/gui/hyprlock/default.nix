{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.hyprlock;
in {
  options.${namespace}.programs.gui.hyprlock = {
    enable = mkBoolOpt false "Whether or not to enable hyprlock.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.name != null) {
    snowfallorg.users.${config.${namespace}.user.name}.programs.hyprlock = {
      enable = true;
      extraConfig = builtins.readFile ./hyprlock.conf;
    };
  };
}
