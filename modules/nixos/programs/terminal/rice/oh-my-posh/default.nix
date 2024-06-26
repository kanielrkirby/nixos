{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.rice.oh-my-posh;
in {
  options.${namespace}.programs.terminal.rice.oh-my-posh = {
    enable = mkBoolOpt false "Whether or not to enable oh-my-posh.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name}.programs.oh-my-posh = {
      enable = true;
      useTheme = "powerlevel10k_lean";
    };
  };
}
