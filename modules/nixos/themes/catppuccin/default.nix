{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.themes.catppuccin;
in {
  options.${namespace}.themes.catppuccin = {
    enable = mkBoolOpt false "Whether or not to enable catppuccin.";
  };

  config = mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = "mocha";
    };
    home-manager.users.${config.${namespace}.user.name}.catppuccin = {
      enable = true;
      flavor = "mocha";
    };
  };
}
