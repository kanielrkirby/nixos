{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.zoxide;
in {
  options.${namespace}.programs.terminal.tools.zoxide = {
    enable = mkBoolOpt false "Whether or not to enable zoxide.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.name != null) {
    snowfallorg.users.${config.${namespace}.user.name}.programs.zoxide = {
      enable = true;
    };
  };
}
