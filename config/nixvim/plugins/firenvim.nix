{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs; [
      vimPlugins.firenvim
    ];

    extraConfigLua = ''
      vim.fn["firenvim#install"](0)
    '';
  };
}
