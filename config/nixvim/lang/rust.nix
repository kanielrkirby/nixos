{
  programs.nixvim = {
    plugins = {
      treesitter = {
        ensureInstalled = [
          "rust"
        ];
      };
    };
  };
}
