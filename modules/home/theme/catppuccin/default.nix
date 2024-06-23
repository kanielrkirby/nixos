{
  inputs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (inputs) catppuccin;
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt username;

  cfg = config.${namespace}.themes.catppuccin;
in {
  options.${namespace}.themes.catppuccin = {
    enable = mkBoolOpt false "Whether or not to enable catppuccin.";
  };

  config = mkIf cfg.enable {
    imports = [
      catppuccin.nixosModules.catppuccin
    ];

    home-manager.users.${username}.imports = [
      catppuccin.homeManagerModules.catppuccin
    ];
  };
}
