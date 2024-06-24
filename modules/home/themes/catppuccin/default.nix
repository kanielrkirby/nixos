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

  imports = [
    catppuccin.nixosModules.catppuccin
  ];

  config = mkIf cfg.enable {
    programs.catppuccin = {
      enable = true;
      flavor = "mocha";
    };
  };
}
