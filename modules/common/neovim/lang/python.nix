{ pkgs, username, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        servers = {
          # jedi_language_server.enable = true;
        };
      };
    };
  };
}
