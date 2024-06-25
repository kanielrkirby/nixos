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
  ];
}

