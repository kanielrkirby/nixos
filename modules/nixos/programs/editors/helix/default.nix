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

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name} = {
      programs.helix = {
        enable = true;
        defaultEditor = true;
      };
      xdg.configFile."helix/config.toml".source = mkForce ./config.toml;
    };
  };
}
