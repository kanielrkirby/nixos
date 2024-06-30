{
  inputs,
  config,
  lib,
  namespace,
  system,
  ...
}: let
  inherit (inputs) helix;
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.editors.helix;
in {
  options.${namespace}.programs.editors.helix = {
    enable = mkBoolOpt false "Whether or not to enable helix.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    environment = {
      sessionVariables.EDITOR = "hx";
      variables.EDITOR = "hx";
    };
    home-manager.users.${config.${namespace}.user.name} = {
      programs.helix = {
        enable = true;
        package = helix.packages.${system}.default;
        defaultEditor = true;
      };
      xdg.configFile."helix/config.toml".source = mkForce ./config.toml;
      xdg.configFile."helix/languages.toml".source = mkForce ./languages.toml;
    };
  };
}
