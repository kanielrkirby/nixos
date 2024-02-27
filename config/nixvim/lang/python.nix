{ inputs, pkgs, username, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter = {
        ensureInstalled = [
          "python"
        ];
      };
      
      lsp = {
        servers = {
          # jedi_language_server.enable = true;
        };
      };
    };
  };
}
