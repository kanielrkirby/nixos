{ config, lib, inputs, ... }:

{
  options.gearshift.swhkd.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkMerge [
    (lib.mkIf config.gearshift.swhkd.enable {
      environment.systemPackages = [ inputs.swhkd.packages.x86_64-linux.swhkd ];
    })
  ];
}
