{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge mkDefault;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.shells.zsh;
in {
  options.${namespace}.programs.terminal.shells.zsh = {
    enable = mkBoolOpt false "Whether or not to enable zsh.";
    default = mkBoolOpt false "Whether or not to make zsh the default user shell.";
  };

  config = mkMerge [
    (mkIf cfg.default {
      users.defaultUserShell = pkgs.zsh;
    })
    (mkIf cfg.enable {
      programs.zsh = {
        enable = true;
      };
    })
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      home-manager.users.${config.${namespace}.user.name} = {
        programs.fzf.enableZshIntegration = mkDefault true;
        programs.yazi.enableZshIntegration = mkDefault true;
        programs.nix-index.enableZshIntegration = mkDefault true;
        programs.zoxide.enableZshIntegration = mkDefault true;
        programs.carapace.enableZshIntegration = mkDefault true;
        programs.oh-my-posh.enableZshIntegration = mkDefault true;
        programs.kitty.shellIntegration.enableZshIntegration = mkDefault true;
        programs.zellij.enableZshIntegration = mkDefault true;
        programs.zsh = {
          enable = true;
          syntaxHighlighting = {
            enable = true;
          };
          initExtra = ''
            alias y="yazi"
            alias h="hx"
            alias sy="sudo -E yazi"
            alias sh="sudo -E hx"
            alias s="sudo -E"
            alias se="sudo echo"
          '';
        };
      };
    })
  ];
}
