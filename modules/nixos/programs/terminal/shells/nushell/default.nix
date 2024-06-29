{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge mkDefault;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.shells.nushell;
in {
  options.${namespace}.programs.terminal.shells.nushell = {
    enable = mkBoolOpt false "Whether or not to enable nushell.";
    default = mkBoolOpt false "Whether or not to make nushell the default user shell.";
  };

  config = mkMerge [
    (mkIf cfg.default {
      users.defaultUserShell = pkgs.nushell;
    })
    (mkIf (cfg.enable && !config.${namespace}.user.enable) {
      environment.systemPackages = with pkgs; [nushell];
    })
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      home-manager.users.${config.${namespace}.user.name} = {
        programs.zoxide.enableNushellIntegration = mkDefault true;
        programs.yazi.enableNushellIntegration = mkDefault true;
        # programs.eza.enableNushellIntegration = mkDefault true;
        programs.oh-my-posh.enableNushellIntegration = mkDefault true;
        programs.nushell = {
          enable = true;
          extraConfig = /*nu*/ ''
            $env.config = {
              show_banner: false,
              keybindings: [
                {
                  name: fuzzy_history
                  modifier: control
                  keycode: char_r
                  mode: [emacs, vi_normal, vi_insert]
                  event: [
                    {
                      send: ExecuteHostCommand
                      cmd: "do {
                        $env.SHELL = ${pkgs.bash}/bin/bash
                        commandline edit --insert (
                          history
                          | get command
                          | reverse
                          | uniq
                          | str join (char -i 0)
                          | fzf --scheme=history 
                              --read0
                              --layout=reverse
                              --height=40%
                              --bind 'ctrl-/:change-preview-window(right,70%|right)'
                              --preview='echo -n {} | nu --stdin -c \'nu-highlight\' '
                          | decode utf-8
                          | str trim
                        )
                      }"
                    }
                  ]
                }
              ],
            }
          '';
          shellAliases = {
            y = "yazi";
            h = "hx";
            sy = "sudo -E yazi";
            sh = "sudo -E hx";
            s = "sudo -E";
            se = "sudo echo";
          };
          environmentVariables = {};
        };
      };
    })
  ];
}
