{
  lib,
  ...
}: let
  inherit (lib.gearshift) enabled;
in {
  gearshift = {
    dms = {
      sddm = enabled;
    };
    hardware = {
      framework = enabled;
    };
    programs = {
      developer.virtualization.libvirt = enabled;
      editors = {
        helix = enabled;
        vscode = enabled;
      };
      gui = {
        browsers.chromium = enabled;
        feh = enabled;
        hyprlock = enabled;
        launchers.fuzzel = enabled;
      };
      security.pass = enabled;
      terminal = {
        emulators = {
          kitty = enabled;
          neovide = enabled;
        };
        rice.oh-my-posh = enabled;
        tools = {
          bat = enabled;
          btop = enabled;
          eza = enabled;
          fzf = enabled;
          gh = enabled;
          git = enabled;
          mods = enabled;
          pop = enabled;
          tealdeer = enabled;
          zoxide = enabled;
        };
      };
    };
    services.dunst = enabled;
    themes.catppuccin = enabled;
    wms.hyprland = enabled;
  };

  home.stateVersion = "24.11";
}
