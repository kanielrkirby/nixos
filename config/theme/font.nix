{ pkgs, username, ... }:

{
  home-manager = {
    users."${username}" = {
      gtk = {
        font = {
          name = "Noto Sans";
          size = 14;
        };
      };
    };

    fonts.packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "Monaspace" ]; }) ];
    home-manager.users."${username}" = {
      programs.alacritty = {
        settings = {
          font = {
            normal = {
              family = "MonaspiceNe NF";
              style = "Regular";
            };
            italic = {
              family = "MonaspiceRn NF";
              style = "Regular";
            };
          };
        };
      };
    };

    programs.fuzzel = {
      settings = { main = { font = "Noto Sans:weight=medium:size=16"; }; };
    };

    services.mako = {
      font = "Noto Sans 10";
    };
  };
}
