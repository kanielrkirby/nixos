{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.bat = {
      enable = true;
      config = {
        paging = "always";
        pager = "less -RF";
        theme = "catppuccin";
      };
      themes = {
        catppuccin = {
          src = "${
              pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "bat";
                rev = "master";
                sha256 = "sha256-PLbTLj0qhsDj+xm+OML/AQsfRQVPXLYQNEPllgKcEx4=";
              }
            }/themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
  };
}
