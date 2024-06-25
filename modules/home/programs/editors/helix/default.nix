{
  inputs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (inputs) nixvim;
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.programs.editors.helix;
in {
  options.${namespace}.programs.editors.helix = {
    enable = mkBoolOpt false "Whether or not to enable helix.";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
    };
    xdg.configFile."helix/config.toml".source = mkForce ./config.toml;
  };
}
