{
  programs.nixvim = {
    plugins = {
      treesitter.ensureInstalled = [ "bash" ];
      lsp.servers.bashls.enable = true;
    };
  };
}
