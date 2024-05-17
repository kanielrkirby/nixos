{ config, lib, pkgs, ... }:

{
  options.gearshift.browser = {
    chrome.enable = lib.mkEnableOption "Chrome";
    tor.enable = lib.mkEnableOption "Tor";
    firefox.enable = lib.mkEnableOption "Firefox";
    have-all = lib.mkEnableOption "All Browsers";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.gearshift.browser.chrome.enable || config.gearshift.browser.have-all) {
      home-manager.users."${config.gearshift.username}" = {
        programs.chromium = {
          enable = true;
          package = pkgs.chromium;
          commandLineArgs = [
            "--ozone-platform-hint=auto"
            "--enable-features=CanvasOopRasterization,DefaultANGLEVulkan,EnableDrDc,Vulkan,WebMachineLearningNeuralNetwork"
            "--enable-gpu-rasterization"
          ];
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
    (lib.mkIf (config.gearshift.browser.tor.enable || config.gearshift.browser.have-all) {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [ tor-browser ];
    })

    (lib.mkIf (config.gearshift.browser.firefox.enable || config.gearshift.browser.have-all) {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [ firefox ];
    })
  ];
}
