{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.programs.gui.browsers.chromium;
in {
  options.${namespace}.programs.gui.browsers.chromium = {
    enable = mkBoolOpt false "Whether or not to enable chromium.";
  };

  config = mkIf cfg.enable {
    programs.gui.chromium = {
      enable = true;
      extraOpts = {
        "PasswordManagerEnabled" = false;
        "BrowserSignin" = 0;
        "SyncDisabled" = true;
        "SearchSuggestEnabled" = false;
        "PromotionalTabsEnabled" = false;
      };
      initialPrefs = {
        "https_only_mode_auto_enabled" = false;
        "privacy_guide" = {
          "viewed" = true;
        };
        "safebrowsing" = {
          "enabled" = false;
          "enhanced" = false;
        };
        "search" = {
          "suggest_enabled" = false;
        };
        "signin" = {
          "allowed" = false;
        };
        "browser" = {
          "clear_data" = {
            "cache" = true;
            "browsing_data" = true;
            "cookies" = false;
            "cookies_basic" = false;
            "download_history" = true;
            "form_data" = true;
          };
          "has_seen_welcome_page" = true;
          "theme" = {
            "follows_system_colors" = true;
          };
        };
      };
    };
    home-manager.users."${username}" = {
      programs.gui.chromium = {
        enable = true;
        package = lib.optionals cfg.primary pkgs.chromium;
        commandLineArgs = [
          # Performance
          "--ozone-platform-hint=auto"
          "--enable-features=CanvasOopRasterization,DefaultANGLEVulkan,EnableDrDc,Vulkan,WebMachineLearningNeuralNetwork"
          "--enable-gpu-rasterization"

          # Privacy
          "--disable-reading-from-canvas"
        ];
        extensions = [
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # UBlock Origin
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
          "ponfpcnoihfmfllpaingbgckeeldkhle" # Enhancer for YouTube
          "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
          "naepdomgkenhinolocfifgehidddafch" # Browserpass
          "hipekcciheckooncpjeljhnekcoolahp" # Tabliss
          "dabkegjlekdcmefifaolmdhnhdcplklo" # Modern for HN
          "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        ];
      };
    };
  };
}
