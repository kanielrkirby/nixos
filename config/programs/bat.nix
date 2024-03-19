{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.bat = {
      enable = true;
      config = {
        paging = "always";
        pager = "less -RF";
      };
    };
  };
}
