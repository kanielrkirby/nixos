{ username, pkgs, ... }:

{
  imports = [ ./input.nix ./graphics.nix ./workspace.nix ./plugins.nix ];

  xdg.portal = {
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # Necessary
  hyprland.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    libinput.enable = true;
    videoDrivers = [ "modesetting" ];
  };

  home-manager = {
    users."${username}".wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        #debug.overlay = true;

        exec-once = [ "waybar" ];

        misc = {
          force_default_wallpaper = false;
          disable_hyprland_logo = true;
          background_color = "0x000000";
        };
      };
      extraConfig = builtins.readFile ./hypr/binds.conf;
    };
  };
}

