{ config, ... }:

{
  services.mullvad-vpn.enable = true;

  sops.secrets."mullvad.net/username" = { };

#  system.activationScripts.login-to-mullvad-vpn.text = ''
#    source "${config.system.build.setEnvironment}"
#    if [[ "$(mullvad account get)" == "Not logged in on any account" ]]; then
#      mullvad account login "$(cat ${
#        config.sops.secrets."mullvad.net/username".path
#      })"
#    fi
#  '';
}
