{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
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
      home-manager.users.${config.${namespace}.user.name}.programs.nushell = {
        enable = true;
        shellAliases = {
          y = "yazi";
          h = "hx";
          sy = "sudo -E yazi";
          sh = "sudo -E hx";
          s = "sudo -E";
          se = "sudo echo";
        };
      };
    })
  ];
}
