{
  programs.nixvim = {
    plugins = {
      treesitter = {
        ensureInstalled = [
          "toml"
        ];
      };
    };
  };
}
