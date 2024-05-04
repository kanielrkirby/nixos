{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        folding = true;
        indent = true;
      };
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
      ts-autotag.enable = true;
      nvim-autopairs.enable = true;
    };
  };
}
