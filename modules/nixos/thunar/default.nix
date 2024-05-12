{ pkgs, config, lib, ... }:

{
  options.gearshift.thunar = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.thunar.enable {
      programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-volman
          thunar-archive-plugin
          thunar-media-tags-plugin
        ];
      };
    })
  ];
}
