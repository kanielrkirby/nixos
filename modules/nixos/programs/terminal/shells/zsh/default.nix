{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.shells.zsh;
in {
  options.${namespace}.programs.terminal.shells.zsh = {
    enable = mkBoolOpt false "Whether or not to enable zsh.";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.zsh = {
        enable = true;
      };
    })
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      users.users.${config.${namespace}.user.name}.defaultUserShell = pkgs.zsh;
      home-manager.users.${config.${namespace}.user.name}.programs.zsh = {
        enable = true;
      };
    })
  ];
}
