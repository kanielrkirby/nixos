{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.shells.bash;
in {
  options.${namespace}.programs.terminal.shells.bash = {
    enable = mkBoolOpt false "Whether or not to enable bash.";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
  };
}
