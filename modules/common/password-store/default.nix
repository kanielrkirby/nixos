{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.password-store.enable = mkEnableOption "Password Store";

  config = mkIf config.gearshift.password-store.enable {
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
        browsers = [ "brave" ];
      };
    };
  };
}
