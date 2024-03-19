{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    services.mako = {
      enable = true;
      sort = "-time";
      layer = "overlay";
      backgroundColor = "#00000060";
      width = 300;
      height = 110;
      borderSize = 1;
      borderColor = "#FFFFFF80";
      padding = "10";
      borderRadius = 2;
      icons = true;
      maxIconSize = 64;
      defaultTimeout = 5000;
      ignoreTimeout = true;
      font = "Noto Sans 10";
      extraConfig = builtins.readFile "${
          pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "mako";
            rev = "master";
            sha256 = "sha256-nUzWkQVsIH4rrCFSP87mXAka6P+Td2ifNbTuP7NM/SQ=";
          }
        }/src/mocha";
    };
  };
}

