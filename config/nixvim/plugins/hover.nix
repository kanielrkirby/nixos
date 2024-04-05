{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs; [
      vimPlugins.hover-nvim
    ];
  };
}
