{ username, pkgs, ... }:

{
  home-manager.users."${username}" = {
    programs.password-store = {
      enable = true;
      package = pkgs.gopass;
      settings = {
        PASSWORD_STORE_DIR = "/home/${username}/.config/password-store";
      };
    };

    programs.browserpass = {
      enable = true;
      browsers = [ "brave" ];
    };
  };
}
