{
  programs.nixvim = {
    plugins = {
      treesitter = {
        ensureInstalled = [
          "yaml"
        ];
      };
    };
  };
}
