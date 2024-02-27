{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    gearshift.theme.font = {
      monaspace.enable = mkOption {
        type = types.bool;
        default = false;
      };
      noto-sans.enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.theme.font.monaspace.enable {
      fonts.packages = with pkgs;
        [ (nerdfonts.override { fonts = [ "Monaspace" ]; }) ];

      home-manager = {
        users."${config.gearshift.username}" = {
          programs.alacritty = {
            settings = {
              font = {
                normal = {
                  family = "MonaspiceNe NF";
                  style = "Regular";
                };
                italic = {
                  family = "MonaspiceRn NF";
                  style = "Regular";
                };
              };
            };
          };
        };
      };
    })
    (mkIf config.gearshift.theme.font.noto-sans.enable {
      home-manager = {
        users."${config.gearshift.username}" = {
          gtk = {
            font = {
              name = "Noto Sans";
              size = 14;
            };
          };

          programs.fuzzel = {
            settings = { main = { font = "Noto Sans:weight=medium:size=16"; }; };
          };

          services.mako = { font = "Noto Sans 10"; };
        };
      };
    })
  ];
}
