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
      programs.alacritty.settings = {
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

    fonts.packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "Monaspace" ]; }) ];
  };
}
