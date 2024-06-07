{ config, lib, pkgs, ... }:

{
  options.gearshift.mpv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.gearshift.mpv.enable {
    environment.systemPackages = with pkgs; [
      mpv
    ];
  };
}
