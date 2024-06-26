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

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.fzf = {
      enable = true;
    };
  };
}
