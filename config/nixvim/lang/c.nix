{
  programs.nixvim = {
    plugins.treesitter.ensureInstalled = [ "c" ];
  };
}
