{ config, lib, pkgs, ... }:

{
  options.gearshift.password-store.enable = lib.mkEnableOption "Password Store";

  config = lib.mkIf config.gearshift.password-store.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.password-store = {
        enable = true;
        package = pkgs.gopass;
        settings = {
          PASSWORD_STORE_DIR = "/home/${config.gearshift.username}/.config/password-store";
        };
      };

      programs.browserpass = {
        enable = true;
        browsers = [ "chromium" ];
      };
    };
  };
}
