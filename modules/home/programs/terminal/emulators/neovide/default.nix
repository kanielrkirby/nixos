{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.neovide;
in {
  options.${namespace}.programs.terminal.emulators.neovide = {
    enable = mkBoolOpt false "Whether or not to enable neovide.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [neovide];
    xdg.configFile."neovide/config.toml".text = ''
      [font]
      normal = "MonaspiceNe NF"
      italic = "MonaspiceRn NF"
      size = 14
    '';
    programs.zsh.initExtra = ''
      export EDITOR="neovide --no-fork"
      alias svim="sudo -E neovide"
    '';
  };
}
