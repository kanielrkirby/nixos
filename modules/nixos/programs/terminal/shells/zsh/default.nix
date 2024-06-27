{
  pkgs,
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
      users.defaultUserShell = pkgs.zsh;
      programs.zsh = {
        enable = true;
      };
    })
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      home-manager.users.${config.${namespace}.user.name}.programs.zsh = {
        enable = true;
        initExtra = ''
          alias y="yazi";
          alias h="hx";
          alias sy="sudo -E yazi";
          alias sh="sudo -E hx";
          alias s="sudo -E";
        '';
      };
    })
  ];
}
