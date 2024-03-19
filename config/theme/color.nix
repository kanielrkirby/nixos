{ username, pkgs, ... }:

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
    #gnome3.gnome-themes-extra

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
  };
}
