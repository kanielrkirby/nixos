{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.${namespace}.programs.gui.browsers.chromium;
in {
  config = mkIf cfg.enable {
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
}
