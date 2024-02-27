{ username, inputs, pkgs, ... }:

{
  home-manager = {
    users."${username}".wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
 #         "hyprpm enable hyprbars"
        ];
      };
      plugins = [
 #       inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      ];
    };
  };
}

