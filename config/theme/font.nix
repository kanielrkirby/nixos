
{ self, inputs, pkgs, username, config, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./programs/alacritty.nix
    ./programs/atuin.nix
    ./programs/bat.nix
    ./programs/btop.nix
    ./programs/chromium.nix
    ./programs/eza.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/starship.nix
    ./programs/swaylock.nix
    ./programs/tealdeer.nix
    ./programs/waybar.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  home-manager = {
    useGlobalPkgs = true;

    users."${username}" = {
      home.stateVersion = "23.11";

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
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      home.packages = with pkgs; [
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
    };
  };

  security.pam.services.swaylock = { };
}
