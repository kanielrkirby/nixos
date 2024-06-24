{
  lib,
  ...
}: let
  inherit (lib.gearshift) enabled;
in {
  gearshift = {
    dms.sddm = enabled;

    hardware = {
      battery = enabled;
      boot.fs.zfs = enabled;
      framework = enabled;
      pipewire = enabled;
      opengl = enabled;
    };

    services = {
      tlp = enabled;
      mullvad-vpn = enabled;
    };

    wms.hyprland = enabled;

    network = {
      enable = true;
      firewall = enabled;
    };

    nix.defaultSettings = enabled;

    programs = {
      gui = {
        feh = enabled;
        foliate = enabled;
        hyprshade = enabled;
        libnotify = enabled;
        mpv = enabled;
        playerctl = enabled;
        thunar = enabled;
        wallpaper = enabled;
        browsers = {
          chromium = enabled;
          firefox = enabled;
          tor = enabled;
        };
        localsend = enabled;
        signal = enabled;
      };
      nix = {
        comma = enabled;
        up = enabled;
        nd = enabled;
        ns = enabled;
        nh = enabled;
      };
      security = {
        gnupg = enabled;
        sops = enabled;
        ssh = enabled;
      };
      terminal = {
        shells = {
          bash = enabled;
          zsh = enabled;
        };
        tools = {
          age = enabled;
          curl = enabled;
          diffutils = enabled;
          fd = enabled;
          findutils = enabled;
          gnupg = enabled;
          httpie = enabled;
          mods = enabled;
          pop = enabled;
          rg = enabled;
          rip = enabled;
          sd = enabled;
          util-linux = enabled;
          coreutils = enabled;
          wget = enabled;
        };
      };
      wayland = {
        grim = enabled;
        slurp = enabled;
        swappy = enabled;
        wf-screenrec = enabled;
        wl-clipboard = enabled;
        ydotool = enabled;
      };
    };
  };

  sound.enable = true;
}
