{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter.ensureInstalled = [ "hyprlang" ];
    };
  };
}
