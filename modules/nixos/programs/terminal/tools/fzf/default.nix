{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.fzf;
in {
  options.${namespace}.programs.terminal.tools.fzf = {
    enable = mkBoolOpt false "Whether or not to enable fzf.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.name != null) {
    snowfallorg.users.${config.${namespace}.user.name}.home.config.programs.fzf = {
      enable = true;
    };
  };
}
