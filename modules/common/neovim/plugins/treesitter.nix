{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
      };

      ts-autotag.enable = true;
      
      nvim-autopairs.enable = true;
    };
  };
}
