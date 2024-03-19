{ pkgs, username, config, ... }:

{
  home-manager.users."${username}" = {
    gtk = {
      enable = true;

      iconTheme = {
        package = pkgs.fluent-icon-theme;
        name = "Fluent-dark";
      };

      font = {
        name = "Noto Sans";
        size = 14;
      };
    };

    xdg.configFile = {
      "gtk-4.0/assets".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
  };
}
