{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.gnupg.enable = mkEnableOption "GPG";

  config = mkIf config.gearshift.gnupg.enable {
    programs.gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };

    sops.secrets = {
      "gpg/primary/key" = {};
      "gpg/primary/content" = {};
      "gpg/primary/passphrase" = {};
    };

#  system.activationScripts.import-gpg-keys-from-sops.text = ''
#    source ${config.system.build.setEnvironment}
#    gpg_keyname="$(cat "${config.sops.secrets."gpg/primary/key".path}")"
#    gpg_output="$(gpg --list-secret-keys | grep "$gpg_keyname")"
#
#    if [[ "$gpg_output" == "" ]]; then
#      gpg --batch --passphrase-file "${config.sops.secrets."gpg/primary/passphrase".path}" --import "${config.sops.secrets."gpg/primary/content".path}"
#    fi
#  '';
  };
}

