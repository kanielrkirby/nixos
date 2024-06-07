{ config, lib, pkgs, ... }:

{
  options.gearshift.mullvad-vpn.enable = lib.mkEnableOption "Mullvad";

  config = lib.mkIf config.gearshift.mullvad-vpn.enable {
    services.mullvad-vpn.enable = true;

    home-manager.users."${config.gearshift.username}".wayland.windowManager.hyprland.extraConfig = ''
      exec-once = mullvad connect
    '';

    sops.secrets."mullvad.net/username" = { };

#  system.activationScripts.login-to-mullvad-vpn.text = ''
#    source "${config.system.build.setEnvironment}"
#    if [[ "$(mullvad account get)" == "Not logged in on any account" ]]; then
#      mullvad account login "$(cat ${
#        config.sops.secrets."mullvad.net/username".path
#      })"
#    fi
#  '';
  };
}
