{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    home.packages = with pkgs; [ libnotify ];

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
    };
  };
}

