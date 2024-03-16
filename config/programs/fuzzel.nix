{ username, ... }:

{
  home-manager.users."${username}" = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          icon-theme = "Fluent-dark";
          width = 25;
          font = "Noto Sans:weight=medium:size=16";
          line-height = 16;
          fields = "name,generic,comment,categories,filename,keywords";
          terminal = "alacritty -e";
          prompt = "> ";
          layer = "overlay";
        };
        colors = {
          background = "1e1e2edd";
          text = "cdd6f4ff";
          match = "f38ba8ff";
          selection = "585b70ff";
          selection-match = "f38ba8ff";
          selection-text = "cdd6f4ff";
          border = "b4befeff";
        };

        border = { radius = 6; };

        dmenu = { exit-immediately-if-empty = true; };
      };
    };
  };
}
