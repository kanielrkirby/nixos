{ config, lib, pkgs, inputs, ... }:

with lib;
{
  options.gearshift = {
    dm = {
      sddm.enable = mkEnableOption "SDDM";
      greetd.enable = mkEnableOption "GreetD";
      gdm.enable = mkEnableOption "GDM";
    };
  };

  config = mkMerge [
    ({
      assertions = [
        {
          assertion = (lib.length (lib.filter (x: x) [
            config.gearshift.dm.sddm.enable
            config.gearshift.dm.gdm.enable
            config.gearshift.dm.greetd.enable
          ]) <= 1);
          message = "You can only have one Display Manager enabled";
        }
      ];
    })

    (mkIf config.gearshift.dm.sddm.enable {
      home-manager.users."${config.gearshift.username}".home.packages = with pkgs.libsForQt5; [
        qtgraphicaleffects
        qtsvg
        qtquickcontrols
      ];

      services.xserver.displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    })

    (mkIf config.gearshift.dm.gdm.enable {
      services.xserver.displayManager = {
        gdm = {
          enable = true;
          wayland.enable = true;
        };
      };
    })

    (mkIf config.gearshift.dm.greetd.enable {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command =
              "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
            user = "greeter";
          };
        };
      };
    
      systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    })
  ];
}
