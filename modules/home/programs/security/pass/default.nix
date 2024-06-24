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

  config = mkIf cfg.enable {
    programs.password-store = {
      enable = true;
      package = pkgs.gopass;
      settings = {
        PASSWORD_STORE_DIR = "$HOME/.config/password-store";
      };
    };

    programs.browserpass = {
      enable = true;
      browsers = ["chromium"];
    };
  };
}
