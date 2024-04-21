{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    gearshift.theme.gtk.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.theme.catppuccin.enable {
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
