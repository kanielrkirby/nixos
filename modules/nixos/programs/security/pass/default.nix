{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.security.pass;
in {
  options.${namespace}.programs.security.pass = {
    enable = mkBoolOpt false "Whether or not to enable pass.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name} = {
      programs.password-store = {
        enable = true;
        package = pkgs.gopass;
        settings = {
          PASSWORD_STORE_DIR = "/home/${config.${namespace}.user.name}/.config/password-store";
        };
      };

      programs.browserpass = {
        enable = true;
        browsers = ["chromium"];
      };
    };
  };
}
