{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [ git ];

  home-manager.users."${username}" = {
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
