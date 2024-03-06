{
  programs.nixvim = {
    plugins.treesitter.ensureInstalled = [ "cpp" ];
  };
}
