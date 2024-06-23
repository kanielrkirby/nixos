{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.neovide;
in {
  options.${namespace}.programs.terminal.tools.neovide = {
    enable = mkBoolOpt false "Whether or not to enable neovide.";
  };

  config = mkIf cfg.enable {
    programs.neovide = {
      enable = true;
    };

    home-manager.users."${config.gearshift.username}" = {
      xdg.configFile."neovide/config.toml".text = ''
        [font]
        normal = "MonaspiceNe NF"
        italic = "MonaspiceRn NF"
        size = 14
      '';

      programs.zsh.initExtra = ''
        export EDITOR="neovide --no-fork"
      '';
    };
  };
}
