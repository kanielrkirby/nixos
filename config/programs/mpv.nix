{ config, username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
      ];
    };
  };
}
