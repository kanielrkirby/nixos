{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.security.gnupg;
in {
  options.${namespace}.programs.security.gnupg = {
    enable = mkBoolOpt false "Whether or not to enable gnupg.";
  };

  config = mkIf cfg.enable {
    programs.gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };

    # sops.secrets = {
    #   "gpg/primary/key" = {};
    #   "gpg/primary/content" = {};
    #   "gpg/primary/passphrase" = {};
    # };
  };
}
