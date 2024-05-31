{ config, lib, ... }:

{
  options.gearshift.tealdeer.enable = lib.mkEnableOption "TealDeer";

  config = lib.mkIf config.gearshift.tealdeer.enable {
    home-manager.users."${config.gearshift.username}" = {
      programs.tealdeer.enable = true;
    };
  };
}
