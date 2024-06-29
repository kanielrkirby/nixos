{
  inputs,
  system,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wayland.waybar;
in {
  options.${namespace}.programs.wayland.waybar = {
    enable = mkBoolOpt false "Whether or not to enable waybar.";
  };

  config = mkIf (cfg.enable && config.${namespace}.user.enable) {
    home-manager.users.${config.${namespace}.user.name} = {
      programs.waybar = {
        enable = true;
        package = inputs.waybar.packages.${system}.default;
      };
    };
    users.users.${config.${namespace}.user.name}.extraGroups = ["input"];
  };
}
