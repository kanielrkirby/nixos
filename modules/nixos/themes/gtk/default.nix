{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.themes.gtk;
in {
  options.${namespace}.themes.gtk = {
    enable = mkBoolOpt false "Whether or not to enable default gtk theme.";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.${namespace}.user.name} = {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
      gtk = {
        enable = true;
  
        # iconTheme = {
        #   package = pkgs.fluent-icon-theme;
        #   name = "Fluent-dark";
        # };
  
        font = {
          name = "Noto Sans";
          size = 14;
        };
      };
  
      home.pointerCursor = mkForce {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 16;
      };
  
      # xdg.configFile = {
      #   "gtk-2.0/assets".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/assets";
      #   "gtk-2.0/gtkrc".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/gtkrc";
      #   "gtk-2.0/main.rc".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/main.rc";
      #   "gtk-2.0/hacks.rc".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/hacks.rc";
      #   "gtk-2.0/apps.rc".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/apps.rc";
      #   "gtk-3.0/assets".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/assets";
      #   "gtk-3.0/gtk.css".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk.css";
      #   "gtk-3.0/gtk-dark.css".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk-dark.css";
      #   "gtk-4.0/assets".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      #   "gtk-4.0/gtk.css".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      #   "gtk-4.0/gtk-dark.css".source =
      #     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      # };
    };
  };
}
