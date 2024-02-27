{ username, inputs, pkgs, ... }:

{
  home-manager = {
    users."${username}".wayland.windowManager.hyprland = {
      settings = {
        monitor = [ ",preferred,auto,1.6" ];

        workspace = [
          "1,persistent:true"
          "2,persistent:true"
          "3,persistent:true"
          "4,persistent:true"
          "5,persistent:true"
          "6,persistent:true"
          "7,persistent:true"
          "8,persistent:true"
          "9,persistent:true"
          "10,persistent:true"
        ];

        general = { layout = "dwindle"; };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
      };
    };
  };
}

