{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.battery;
in {
  options.${namespace}.hardware.battery = {
    enable = mkBoolOpt false "Whether or not to enable battery.";
  };

  config = mkIf cfg.enable {
    systemd.timers."battery-checker" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "battery-checker.service";
      };
    };

    systemd.services."battery-checker" = {
      script = ''
        POWERSUPPLY="/sys/class/power_supply/ACAD/online"
        TOO_LOW="20"
        NOT_CHARGING="0"

        export DISPLAY=":0"
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

        BATTERY_LEVEL="$(${pkgs.acpi}/bin/acpi -b | grep -P -o '[0-9]+(?=%)' | tail -n1)"
        STATUS="$(cat "$POWERSUPPLY")"

        if [[ "$BATTERY_LEVEL" -le "$TOO_LOW" ]] && [[ "$STATUS" == "$NOT_CHARGING" ]]
        then
            ${pkgs.libnotify}/bin/notify-send -u critical -t 3000 "Battery low" "Battery level is ''${BATTERY_LEVEL}%!"
        fi

        exit 0
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };
  };
}
