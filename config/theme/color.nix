{ username, pkgs, inputs, ... }:

{
  home-manager.users."${username}" = {
    gtk = {
      theme = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          # accents = [ "pink" ];
          # size = "compact";
          # tweaks = [ "rimless" "black" ];
          variant = "mocha";
        };
      };
    };

    programs.chromium.extensions = [
      "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin Theme
    ];

    programs.alacritty = {
      settings.import = [
        "${
          pkgs.fetchFromGitHub {
            owner = "alacritty";
            repo = "alacritty-theme";
            rev = "master";
            sha256 = "sha256-+35S6eQkxLBuS/fDKD5bglQDIuz2xeEc5KSaK6k7IjI=";
          }
        }/themes/catppuccin_mocha.toml"
      ];
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
    };

    xdg.configFile."zsh/catppuccin_mocha.zsh".source = "${
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "master";
          sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
        }
      }/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";

    xdg.configFile."btop/themes/catppuccin_mocha.theme".source = "${
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "btop";
          rev = "master";
          sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
        }
      }/themes/catppuccin_mocha.theme";

    programs.bat = {
      config = { theme = "catppuccin"; };
      themes = {
        catppuccin = {
          src = "${
              pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "bat";
                rev = "master";
                sha256 = "sha256-POoW2sEM6jiymbb+W/9DKIjDM1Buu1HAmrNP0yC2JPg=";
              }
            }/themes/Catppuccin Mocha.tmTheme";
        };
      };
    };

    programs.btop = {
      enable = true;
      settings = { color_theme = "catppuccin_mocha"; };
    };

    programs.fuzzel = {
      settings = {
        colors = {
          background = "1e1e2edd";
          text = "cdd6f4ff";
          match = "f38ba8ff";
          selection = "585b70ff";
          selection-match = "f38ba8ff";
          selection-text = "cdd6f4ff";
          border = "b4befeff";
        };
      };
    };

    programs.fzf = {
      colors = {
        "bg+" = "#313244";
        bg = "#1e1e2e";
        spinner = "#f5e0dc";
        hl = "#f38ba8";
        fg = "#cdd6f4";
        header = "#f38ba8";
        info = "#cba6f7";
        pointer = "#f5e0dc";
        marker = "#f5e0dc";
        "fg+" = "#cdd6f4";
        prompt = "#cba6f7";
        "hl+" = "#f38ba8";
      };
    };

    services.mako = {
      extraConfig = builtins.readFile "${
          pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "mako";
            rev = "master";
            sha256 = "sha256-nUzWkQVsIH4rrCFSP87mXAka6P+Td2ifNbTuP7NM/SQ=";
          }
        }/src/mocha";
    };

    programs.starship = let flavour = "mocha";
    in {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "starship";
        rev = "master";
        sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
      } + /palettes/${flavour}.toml)) // {
        palette = "catppuccin_${flavour}";
      };
    };

    programs.swaylock = {
      settings = {
        color = "1e1e2e";
        bs-hl-color = "f5e0dc";
        caps-lock-bs-hl-color = "f5e0dc";
        caps-lock-key-hl-color = "a6e3a1";
        inside-color = "00000000";
        inside-clear-color = "00000000";
        inside-caps-lock-color = "00000000";
        inside-ver-color = "00000000";
        inside-wrong-color = "00000000";
        key-hl-color = "a6e3a1";
        layout-bg-color = "00000000";
        layout-border-color = "00000000";
        layout-text-color = "cdd6f4";
        line-color = "00000000";
        line-clear-color = "00000000";
        line-caps-lock-color = "00000000";
        line-ver-color = "00000000";
        line-wrong-color = "00000000";
        ring-color = "b4befe";
        ring-clear-color = "f5e0dc";
        ring-caps-lock-color = "fab387";
        ring-ver-color = "89b4fa";
        ring-wrong-color = "eba0ac";
        separator-color = "00000000";
        text-color = "cdd6f4";
        text-clear-color = "f5e0dc";
        text-caps-lock-color = "fab387";
        text-ver-color = "89b4fa";
        text-wrong-color = "eba0ac";
      };
    };

    xdg.configFile."tealdeer/config.toml".text = ''
      [display]
      compact = false
      use_pager = false

      [style.description]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [style.command_name]
      foreground = { rgb = { r = 180, g = 160, b = 220 } }

      [style.example_code]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [style.example_text]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [style.example_variable]
      foreground = { rgb = { r = 205, g = 214, b = 244 } }

      [updates]
      auto_update = true
      auto_update_interval_hours = 24
    '';

    xdg.configFile."waybar".source = builtins.path {
      name = "waybar-config";
      path = "${
          pkgs.fetchFromGitHub {
            owner = "sephid86";
            repo = "archas";
            rev = "master";
            sha256 = "sha256-7EtoMTBbdDh+78N21pQocMOp+hvBVuTB93Pr5OSG0Xw=";
          }
        }/skel/.config/waybar";
      filter = path: type:
        builtins.elem (baseNameOf path) [ "config" "style.css" ];
    };

    programs.neomutt.extraConfig = builtins.readFile "${
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "neomutt";
          rev = "master";
          sha256 = "sha256-7l+4vL+4wX9p+9HbqF4C8xhXjyjNzO1wBp9n9bWk8Xw=";
        }
      }/neomuttrc";
  };

  services.xserver.displayManager = {
    sddm.theme = "${
        import ../derivations/sddm-catppuccin.nix { inherit pkgs; }
      }/src/catppuccin-mocha";
  };
}
