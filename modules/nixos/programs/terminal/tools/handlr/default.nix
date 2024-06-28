{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.handlr;
in {
  options.${namespace}.programs.terminal.tools.handlr = {
    enable = mkBoolOpt false "Whether or not to enable handlr.";
    noShadow = mkBoolOpt true "Opt out of shadowing xdg-open with handlr.";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ handlr-regex ];
    })
    (mkIf (!cfg.noShadow) {
      environment.systemPackages = with pkgs; [
        (writeShellScriptBin "xdg-open" ''
          "${pkgs.handlr-regex}/bin/handlr" open "$@";
        '')
      ];
    })
  ];
}
