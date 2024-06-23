{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wayland.wf-screenrec;
in {
  options.${namespace}.programs.wayland.wf-screenrec = {
    enable = mkBoolOpt false "Whether or not to enable wf-screenrec.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wf-screenrec
    ];
  };
}
