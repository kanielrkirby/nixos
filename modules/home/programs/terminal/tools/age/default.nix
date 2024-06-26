{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.age;
in {
  options.${namespace}.programs.terminal.tools.age = {
    enable = mkBoolOpt false "Whether or not to enable age.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age
    ];
  };
}
