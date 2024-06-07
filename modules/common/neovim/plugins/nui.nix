{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.nui-nvim
    ];
  };
}
