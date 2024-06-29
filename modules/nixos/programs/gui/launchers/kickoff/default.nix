{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.gui.launchers.kickoff;
in {
  options.${namespace}.programs.gui.launchers.kickoff = {
    enable = mkBoolOpt false "Whether or not to enable kickoff.";
  };

  config = mkMerge [
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      home-manager.users.${config.${namespace}.user.name} = {
        xdg.configFile."kickoff/config.toml".text = /*toml*/ ''
          prompt = ""

          padding = 100

          fonts = [
            'MonaspiceNe NF',
          ]
          font_size = 32.0

          [history]
          decrease_interval = 48

          [keybindings]
          paste = ["ctrl+v"]
          execute = ["KP_Enter", "Return"]
          delete = ["KP_Delete", "Delete", "BackSpace"]
          delete_word = ["ctrl+KP_Delete", "ctrl+Delete", "ctrl+BackSpace"]
          complete = ["Tab"]
          nav_up = ["Up", "alt+k"]
          nav_down = ["Down", "alt+j"]
          exit = ["Escape"]

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
