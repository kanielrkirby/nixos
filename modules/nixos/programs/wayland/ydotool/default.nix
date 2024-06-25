{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  socket = "/home//.ydotool_socket";

  cfg = config.${namespace}.programs.wayland.ydotool;
in {
  options.${namespace}.programs.wayland.ydotool = {
    enable = mkBoolOpt false "Whether or not to enable ydotool.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ydotool
    ];

    environment.sessionVariables = {
      YDOTOOL_SOCKET = socket;
    };

    systemd.services.start-ydotool = {
      description = "Start ydotoold background service";

      wantedBy = ["multi-user.target"];
      after = ["network.target"];

      serviceConfig = {
        ExecStart = ''${pkgs.ydotool}/bin/ydotoold --socket-path="${socket}"'';
        Type = "simple";
        Restart = "always";
      };

      restartIfChanged = true;
    };
  };
}
