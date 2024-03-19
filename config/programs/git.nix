{ config, ... }:

{
  home-manager.users."${config.username}" = {
    programs.gh = {
      enable = true;
      settings = {
        version = "1";
        git_protocol = "ssh";
      };
    };

    programs.git = {
      enable = true;
      userName = "Kaniel Kirby";
      userEmail = "piratey7007@runbox.com";
    };
  };
}
