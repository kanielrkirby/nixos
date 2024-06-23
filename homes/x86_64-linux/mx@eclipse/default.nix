{
  lib,
  namespace,
  ...
}: let
  inherit (lib.${namespace}) homeVersion enabled;
in {
  ${namespace} = {
    themes.catppuccin = enabled;

    dms.sddm = enabled;

    hardware = {
      battery = enabled;
      boot.fs.zfs = enabled;
      framework = enabled;
      pipewire = enabled;
      opengl = enabled;
    };

    services = {
      dunst = enabled;
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
        hyprlock = enabled;
        hyprshade = enabled;
        libnotify = enabled;
        mpv = enabled;
        playerctl = enabled;
        thunar = enabled;
        wallpaper = enabled;
        launchers = {
          anyrun = enabled;
          fuzzel = enabled;
        };
        browsers = {
          chromium = enabled;
          firefox = enabled;
          tor = enabled;
        };
        localsend = enabled;
        signal = enabled;
        nix = {
          comma = enabled;
          up = enabled;
          nd = enabled;
          ns = enabled;
          nh = enabled;
        };
        security = {
          gnupg = enabled;
          pass = enabled;
          sops = enabled;
          ssh = enabled;
        };
        terminal = {
          emulators = {
            kitty = enabled;
            neovide = enabled;
          };
          rice.oh-my-posh = enabled;
          shells = {
            bash = enabled;
            zsh = enabled;
          };
          tools = {
            age = enabled;
            bat = enabled;
            btop = enabled;
            curl = enabled;
            diffutils = enabled;
            eza = enabled;
            fd = enabled;
            findutils = enabled;
            fzf = enabled;
            gh = enabled;
            git = enabled;
            gnupg = enabled;
            httpie = enabled;
            mods = enabled;
            pop = enabled;
            rg = enabled;
            rip = enabled;
            sd = enabled;
            tealdeer = enabled;
            util-linux = enabled;
            uutils-coreutils = enabled;
            wget = enabled;
            zoxide = enabled;
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
  };

  sound.enable = true;

  home.stateVersion = homeVersion;
}
