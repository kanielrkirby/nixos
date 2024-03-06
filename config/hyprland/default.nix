{ username, pkgs, ... }:

{
  imports = [
    ./binds.nix
    ./input.nix
    ./graphics.nix
    ./workspace.nix
    ./plugins.nix
  ];

  xdg.portal = {
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    libinput.enable = true;
    videoDrivers = [ "modesetting" ];

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${import ./derivations/sddm-catppuccin.nix { inherit pkgs; }}/src/catppuccin-mocha";
     #   autoLogin = {
     #     relogin = true;
     #   };
      };
     # autoLogin = {
     #   enable = true;
     #   user = "mx";
     # };
    };
  };

  home-manager = {
    users.${username}.wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        #debug.overlay = true;

        exec-once = [
          "waybar"
        ];

        misc = {
          force_default_wallpaper = false;
          disable_hyprland_logo = true;
          background_color = "0x000000";
        };
      };
    };
  };
}

