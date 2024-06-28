{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.gui.launchers.kickoff;
in {
  options.${namespace}.programs.gui.launchers.kickoff = {
    enable = mkBoolOpt false "Whether or not to enable kickoff.";
  };

  config = mkMerge [
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      home-manager.users.${config.${namespace}.user.name} = {
        xdg.configFile."kickoff/config.toml".text = /*toml*/ ''
          [colors]
          background = '#282c34aa'
          prompt = '#abb2bfff'
          text = '#ffffffff'
          text_query = '#e5c07bff'
          text_selected = '#61afefff'
        '';
      };
    })
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [kickoff];
    })
  ];
}
