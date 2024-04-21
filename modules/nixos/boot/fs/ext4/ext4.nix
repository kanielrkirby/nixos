{ pkgs, config, lib, ... }:

with lib;
{
  options.gearshift.ext4 = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.ext4.enable {
      assertions = [
        {
          assertion = config.gearshift.ext4.enable;
          message = "EXT4 hasn't been configured yet. Sorry :(";
        }
      ];
    })
  ];
}
