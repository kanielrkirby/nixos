{ config, lib, pkgs, ... }:

with lib;
let
  socket = "/home/${config.gearshift.username}/.ydotool_socket";
in
{
  options.gearshift = {
    ydotool.enable = mkEnableOption "ydotool";
  };

  config = mkIf config.gearshift.ydotool.enable {
    environment.systemPackages = with pkgs; [
      ydotool
    ];

    environment.sessionVariables = {
      YDOTOOL_SOCKET = socket;
    };

    systemd.services.start-ydotool = {
      description = "Start ydotoold background service";

      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        ExecStart = ''${pkgs.ydotool}/bin/ydotoold --socket-path="${socket}"'';
        Type = "simple";
        Restart = "always";
      };

      restartIfChanged = true;
    };
  };
}
