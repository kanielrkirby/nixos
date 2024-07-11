{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.wf-recorder = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.wf-recorder.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs; [
        wf-recorder
      ];
    })
  ];
}
