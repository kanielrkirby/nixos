{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.swaylock = {
      enable = true;
    };
  };
}
