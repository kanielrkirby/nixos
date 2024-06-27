{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.neovide;
in {
  options.${namespace}.programs.terminal.emulators.neovide = {
    enable = mkBoolOpt false "Whether or not to enable neovide.";
  };

  config = mkMerge [
    (mkIf (cfg.enable && config.${namespace}.user.enable) {
      home-manager.users.${config.${namespace}.user.name} = {
        xdg.configFile."neovide/config.toml".text = ''
          [font]
          normal = "MonaspiceNe NF"
          italic = "MonaspiceRn NF"
          size = 14
        '';
      };
    })
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [neovide];
    })
  ];
}
