{ config, lib, inputs, pkgs, ... }:

with lib;
{
  options.gearshift = {
    username = mkOption {
      type = types.str;
      default = "mx";
    };
    version = {
      main = mkOption {
        type = types.str;
        default = "24.05";
      };
      home = mkOption {
        type = types.str;
        default = "23.11";
      };
    };
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
    };
    kb-layout = mkOption {
      type = types.str;
      default = "us";
    };
    timeZone = mkOption {
      type = types.str;
      default = "America/Chicago";
    };
    hostName = mkOption {
      type = types.str;
    };
    hostId = mkOption {
      type = types.str;
      default = "3759be58";
    };
  };

  config = {
    i18n.defaultLocale = config.gearshift.locale;
  
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

    system.nixos.label = "";

    home-manager = {
      useGlobalPkgs = true;

      users."${config.gearshift.username}" = {
        home = {
          stateVersion = config.gearshift.version.home;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      git
    ];

    gearshift.scripts = {
      nix-collection.enable = true;
    };

    system.stateVersion = config.gearshift.version.main;
  };
}
