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
      initialPrefs = builtins.fromJSON builtins.readFile ../../extra/brave-preferences.json;
    };

    home.packages = with pkgs; [ tor-browser-bundle-bin ];
  };
}
