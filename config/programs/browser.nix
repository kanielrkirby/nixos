{ username, pkgs, config, ... }:

{
  home-manager.users."${username}" = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [ "--ozone-platform-hint=wayland" ];
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # UBlock Origin
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "naepdomgkenhinolocfifgehidddafch" # Browserpass
        "hipekcciheckooncpjeljhnekcoolahp" # Tabliss
        "dabkegjlekdcmefifaolmdhnhdcplklo" # Modern for HN
        "nffaoalbilbmmfgbnbgppjihopabppdk" # Video Speed Controller
        "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      ];
    };

    home.packages = with pkgs; [ tor-browser-bundle-bin ];
  };

#  system.activationScripts.symlink-brave-preferences.text = ''
#    source "${config.system.build.setEnvironment}"
#    _SOURCE="/etc/nixos/extra/brave-preferences.json"
#    _DEST="/home/${username}/.config/BraveSoftware/Brave-Browser/Default/Preferences"
#
#    if [[ ! -f "$_SOURCE" ]]; then
#      echo "Failed to copy preferences file from Brave. No source file found at \"$_SOURCE\""
#    elif [[ -f "$_DEST" ]]; then
#      echo "Failed to copy preferences file from Brave. Try deleting /home/${username}/.config/BraveSoftware/Brave-Browser/Default/Preferences."
#    else
#      cp "$_SOURCE" "$_DEST"
#    fi
#  '';
}
