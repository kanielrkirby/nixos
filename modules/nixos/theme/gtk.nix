{ config, lib, pkgs, ... }:

{
  options = {
    gearshift.theme.gtk.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.theme.gtk.enable {
      home-manager.users."${config.gearshift.username}" = { config, ... }: {
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
    
        home.pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 16;
        };
    
        xdg.configFile = {
          "gtk-2.0/assets".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/assets";
          "gtk-2.0/gtkrc".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/gtkrc";
          "gtk-2.0/main.rc".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/main.rc";
          "gtk-2.0/hacks.rc".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/hacks.rc";
          "gtk-2.0/apps.rc".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/apps.rc";
          "gtk-3.0/assets".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/assets";
          "gtk-3.0/gtk.css".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk.css";
          "gtk-3.0/gtk-dark.css".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk-dark.css";
          "gtk-4.0/assets".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
          "gtk-4.0/gtk.css".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
          "gtk-4.0/gtk-dark.css".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
        };
    
        programs.fuzzel = {
          settings = {
            main = {
              icon-theme = "Fluent-dark";
            };
          };
        };
      };
    })
  ];
}
