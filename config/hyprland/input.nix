{ username, ... }:

{
  home-manager = {
    users."${username}".wayland.windowManager.hyprland = {
      settings = {
        input = {
          kb_options = ["caps:escape"];
          kb_layout = "us";
          repeat_rate = 100;
          repeat_delay = 200;
          follow_mouse = true;
          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.80;
            disable_while_typing = true;
          };
          sensitivity = 0.3;
        };
  
        device = {
          name = "logitech-mx-master-3-for-mac-1";
          sensitivity = -0.2;
        };
  
        gestures = { workspace_swipe = true; };
      };
    };
  };
}
