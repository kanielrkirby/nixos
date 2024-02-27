{ username, pkgs, ... }:

{
  home-manager = {
    users."${username}" = {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [ ",preferred,auto,1.6" ];

          general = {
            gaps_in = 2;
            gaps_out = 2;
            border_size = 1;
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";
            layout = "dwindle";
            allow_tearing = false;
          };

          decoration = {
            rounding = 3;
            blur.enabled = false;
            drop_shadow = false;
            dim_inactive = false;
          };

          animations.enabled = false;

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          misc.vfr = false;
        };
      };
    };
  };
}

