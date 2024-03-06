{
  programs.nixvim = {
      plugins = {
      treesitter = {
        ensureInstalled = [
          "dockerfile"
        ];
      };
    };
  };
}
