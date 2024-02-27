{ username, pkgs, ... }:

{
  home-manager.users."${username}".home.packages = with pkgs; [
    # These are for SDDM mostly
    libsForQt5.qtgraphicaleffects
    libsForQt5.qtsvg
    libsForQt5.qtquickcontrols
  ];

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
}

