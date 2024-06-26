{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>pf" = {action = "find_files";};
        "<leader>ps" = {action = "live_grep";};
      };
      extensions.fzf-native.enable = true;
    };
  };
}
