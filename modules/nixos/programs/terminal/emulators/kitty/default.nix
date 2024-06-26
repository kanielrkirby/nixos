{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.kitty;
in {
  options.${namespace}.programs.terminal.emulators.kitty = {
    enable = mkBoolOpt false "Whether or not to enable kitty.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.name != null) {
    snowfallorg.users.${config.${namespace}.user.name}.home.config.programs.kitty = {
      enable = true;
    };
  };
}
