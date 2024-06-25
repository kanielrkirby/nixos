{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkMerge mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.framework;
in {
  options.${namespace}.hardware.framework = {
    enable = mkBoolOpt false "Whether or not to enable all framework fixes.";
    soundfix.enable = mkBoolOpt false "Whether or not to enable framework sound fix.";
  };
  config = mkMerge [
    (mkIf (cfg.soundfix.enable || cfg.enable) {
      services.easyeffects = {
        enable = true;
        preset = "lappy_mctopface";
      };

      xdg.configFile."easyeffects/output".source = builtins.fetchGit {
        url = "https://github.com/ceiphr/ee-framework-presets";
        rev = "27885fe00c97da7c441358c7ece7846722fd12fa";
      };
    })
  ];
}

