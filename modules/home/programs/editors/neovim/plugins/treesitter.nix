{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        folding = true;
        indent = true;
      };
      treesitter-refactor.enable = true;
      treesitter-textobjects = {
        enable = true;
        select = {
          enable = true;
          keymaps = {
            af = {query = "@function.outer";};
            "if" = {query = "@function.inner";};
            ac = {query = "@class.outer";};
            ic = {query = "@class.inner";};
            as = {query = "@scope";};
          };
        };
      };
      ts-autotag.enable = true;
      nvim-autopairs.enable = true;
    };
  };
}
