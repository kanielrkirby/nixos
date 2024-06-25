{
  lib,
  ...
}: let
  inherit (lib.gearshift) enabled;
in {
  gearshift = {
    themes.catppuccin = enabled;

    programs = {
      gui = {
        hyprlock = enabled;
        launchers = {
          fuzzel = enabled;
        };
      };
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
          tealdeer = enabled;
          zoxide = enabled;
        };
      };
      security.pass = enabled;
    };
    services = {
      dunst = enabled;
    };
    hardware = {
      framework = enabled;
    };
  };
  home.stateVersion = "24.11";
}
