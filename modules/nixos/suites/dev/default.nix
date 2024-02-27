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
      gearshift.alacritty.enable = true;
      gearshift.bat.enable = true;
      gearshift.browser.have-all = true;
      gearshift.btop.enable = true;
      gearshift.eza.enable = true;
      gearshift.fzf.enable = true;
      gearshift.gh.enable = true;
      gearshift.git.enable = true;
      gearshift.less.enable = true;
      gearshift.mods.enable = true;
      gearshift.neovim.enable = true;
      # config.gearshift.ollama.enable = true;
      gearshift.starship.enable = true;
      gearshift.tealdeer.enable = true;
      gearshift.vscode.enable = true;
      gearshift.zoxide.enable = true;
      gearshift.zsh.enable = true;
    })
  ];
}
