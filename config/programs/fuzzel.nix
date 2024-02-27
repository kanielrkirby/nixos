{ username, ... }:

{
  home-manager.users."${username}" = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          width = 25;
          line-height = 16;
          fields = "name,generic,comment,categories,filename,keywords";
          terminal = "alacritty -e";
          prompt = "> ";
          layer = "overlay";
        };

        border = { radius = 6; };

        dmenu = { exit-immediately-if-empty = true; };
      };
    };
  };
}
