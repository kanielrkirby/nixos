{ config, lib, pkgs, ... }:

with lib;
{
  options.gearshift.suite.dev = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkMerge [
    (mkIf config.gearshift.suite.dev.enable {
      gearshift = {
        ripgrep.enable = true;
        yarn.enable = true;
        alacritty.enable = true;
        bat.enable = true;
        browser.have-all = true;
        btop.enable = true;
        eza.enable = true;
        fzf.enable = true;
        feh.enable = true;
        gh.enable = true;
        git.enable = true;
        less.enable = true;
        lazysql.enable = true;
        mods.enable = true;
        neovim.enable = true;
        starship.enable = true;
        tealdeer.enable = true;
        vscode.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
      };
    })
  ];
}
