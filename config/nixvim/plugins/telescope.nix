{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>pf" = { action = "find_files"; };
        "<leader>ps" = { action = "grep_string"; };
      };
      extensions.fzf-native.enable = true;
    };
  };
}
