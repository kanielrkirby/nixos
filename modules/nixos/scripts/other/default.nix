{ config, lib, ... }:

{
  options.gearshift = {
    scripts.other.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.scripts.other.enable {
      gearshift.scripts = {
        nope.enable = true;
      };
    })
  ];
}
