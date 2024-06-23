{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.shells.zsh;
in {
  options.${namespace}.programs.terminal.shells.zsh = {
    enable = mkBoolOpt false "Whether or not to enable zsh.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
    };
  };
}
