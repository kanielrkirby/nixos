{ username, pkgs, ... }:

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

  system.activationScripts.symlink-brave-preferences.text = ''
    _SOURCE="/etc/nixos/extra/brave-preferences.json"
    _DEST="/home/${username}/.config/BraveSoftware/Brave-Browser/Default/Preferences"

    if [[ ! -f "$_SOURCE" ]]; then
      echo "Failed to copy preferences file from Brave. No source file found at \"$_SOURCE\""
    fi
    if [[ -f "$_DEST" ]]; then
      echo "Failed to copy preferences file from Brave. Try deleting /home/${username}/.config/BraveSoftware/Brave-Browser/Default/Preferences."
    fi

    cp "$_SOURCE" "$_DEST"
  '';
}
