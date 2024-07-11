{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.httpie = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.httpie.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        httpie
      ];
    })
  ];
}
