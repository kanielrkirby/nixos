{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (builtins) readFile;
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.gitui;
in {
  options.${namespace}.programs.terminal.tools.gitui = {
    enable = mkBoolOpt false "Whether or not to enable gitui.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name} = {
      programs.gitui = {
        enable = true;
        keyConfig = readFile "${
          pkgs.fetchFromGitHub {
            owner = "extrawurst";
            repo = "gitui";
            rev = "3229c5d5ed7f1ca84d2d5edc4905b1edf6e5aa9b";
            hash = "sha256-M5kGXqf2j8QJXOocj0L1yOZWaSCTeH5T8SRz6tk4v60=";
          }
        }/vim_style_key_config.ron";
      };
    };
  };
}
