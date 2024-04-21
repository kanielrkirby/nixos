{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.browser = {
    brave.enable = mkEnableOption "Brave";
    chrome.enable = mkEnableOption "Chrome";
    tor.enable = mkEnableOption "Tor";
    firefox.enable = mkEnableOption "Firefox";
    have-all = mkEnableOption "All Browsers";
  };

  config = mkMerge [
    (mkIf (config.gearshift.browser.chrome.enable || config.gearshift.browser.brave.enable) {
      home-manager.users."${config.gearshift.username}" = {
        programs.chromium = {
          enable = true;
          package = if config.gearshift.browser.brave.enable then pkgs.brave else pkgs.chrome;
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
        home.packages =
          (if config.gearshift.browser.brave.enable && config.gearshift.browser.chrome.enable then [ pkgs.chrome ] else []);

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
      };
    })
    (mkIf config.gearshift.browser.tor.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [ tor-browser ];
    })

    (mkIf config.gearshift.browser.firefox.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [ firefox ];
    })
  ];
}
