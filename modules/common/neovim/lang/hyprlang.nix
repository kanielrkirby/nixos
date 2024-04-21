{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter.ensureInstalled = [ "hyprlang" ];
    };
    #vim.filetype.add({
    #  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
    #})
    filetype.pattern.".*hypr.*%.conf" = "hyprlang";
    filetype.pattern.".*/hypr/.*%.conf" = "hyprlang";
  };
}
