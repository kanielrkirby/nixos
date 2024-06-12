{ config, lib, pkgs, ... }:

{
  options.gearshift = {
    scripts.nd.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.nd.enable {
      home-manager.users."${config.gearshift.username}".home.packages = [
        (pkgs.writeShellScriptBin "nd" ''
        nix develop path:. -c "${pkgs.zsh}/bin/zsh" $@;
        '')
      ];
    })
  ];
}
