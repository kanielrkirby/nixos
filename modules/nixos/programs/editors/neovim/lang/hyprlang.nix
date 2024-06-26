{pkgs, ...}: {
  programs.nixvim = {
    #vim.filetype.add({
    #  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
    #})
    filetype.pattern.".*hypr.*%.conf" = "hyprlang";
    filetype.pattern.".*/hypr/.*%.conf" = "hyprlang";
  };
}
