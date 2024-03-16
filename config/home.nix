{ self, inputs, pkgs, username, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./alacritty.nix
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./chromium.nix
    ./eza.nix
    ./fuzzel.nix
    ./fzf.nix
    ./starship.nix
    ./swaylock.nix
    ./tealdeer.nix
    ./waybar.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  users = {
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
      initialPassword = "asdf";
    };
    mutableUsers = false;
  };

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  programs.thunar = { enable = true; };

  home-manager = {
    useGlobalPkgs = true;

    users."${username}" = { pkgs, config, ... }: {
      home.stateVersion = "23.11";

      services.easyeffects = {
        enable = true;
        preset = "lappy_mctopface";
      };

      xdg.configFile."easyeffects/output".source = builtins.fetchGit {
        url = "https://github.com/ceiphr/ee-framework-presets";
        rev = "27885fe00c97da7c441358c7ece7846722fd12fa";
      };

      gtk = {
        enable = true;
        theme = {
          name = "Catppuccin-Mocha-Standard-Blue-Dark";
          package = pkgs.catppuccin-gtk.override {
            # accents = [ "pink" ];
            # size = "compact";
            # tweaks = [ "rimless" "black" ];
            variant = "mocha";
          };
        };

        iconTheme = {
          package = pkgs.fluent-icon-theme;
          name = "Fluent-dark";
        };

        font = {
          name = "Noto Sans";
          size = 14;
        };
      };

      xdg.configFile = {
        "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
        "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
        "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      };

      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      home.packages = with pkgs; [
        git
        httpie
        nodejs_21
        wl-clipboard
        fw-ectool
        grim
        slurp
        ripgrep
        hyprshade
        signal-desktop
        brightnessctl
        playerctl
        libnotify
        hyprpaper
        codeium
        pinentry
        powertop
        localsend
        vagrant
        libsForQt5.qtgraphicaleffects
        libsForQt5.qtsvg
        libsForQt5.qtquickcontrols
        foliate
        gimp
        gnome3.gnome-themes-extra
      ];

      programs.less.enable = true;

      xdg.configFile."zsh/catppuccin_mocha.zsh".source =
        "${pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "master";
          sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
        }}/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";

      xdg.configFile."btop/themes/catppuccin_mocha.theme".source = "${pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "btop";
        rev = "master";
        sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
      }}/themes/catppuccin_mocha.theme";

      # home.file.".config/BraveSoftware/Brave-Browser/Default/Preferences".source = "${self}/../extra/brave-preferences.json";

      programs.browserpass = {
        enable = true;
        browsers = [ "brave" ];
      };

      programs.gh = {
        enable = true;
        settings = {
          version = "1";
          git_protocol = "ssh";
        };
      };

      programs.git = {
        enable = true;
        userName = "Kaniel Kirby";
        userEmail = "piratey7007@runbox.com";
      };

      programs.password-store = {
        enable = true;
        package = pkgs.gopass;
        settings = { PASSWORD_STORE_DIR = "/home/${username}/.config/password-store"; };
      };

      services.mako = {
        enable = true;
        sort = "-time";
        layer = "overlay";
        backgroundColor = "#00000060";
        width = 300;
        height = 110;
        borderSize = 1;
        borderColor = "#FFFFFF80";
        padding = "10";
        borderRadius = 2;
        icons = true;
        maxIconSize = 64;
        defaultTimeout = 5000;
        ignoreTimeout = true;
        font = "Noto Sans 10";
        extraConfig = builtins.readFile "${pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "mako";
          rev = "master";
          sha256 = "sha256-nUzWkQVsIH4rrCFSP87mXAka6P+Td2ifNbTuP7NM/SQ=";
        }}/src/mocha";
      };

      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [ vscodevim.vim ];
      };

      # programs.thunderbird = {
      #   enable = true;
      #   profiles = [];
      # };
    };
  };

  security.pam.services.swaylock = { };
}
