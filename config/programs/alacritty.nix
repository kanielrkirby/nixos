{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.alacritty = {
      enable = true;
      settings = {
        window = { opacity = 0.975; };
      };
    };
  };
}
