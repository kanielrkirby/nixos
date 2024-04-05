{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        view_options.show_hidden = true;
      };
    };

    keymaps = [{
      mode = "n";
      key = "<leader>pv";
      action = "<cmd>Oil<CR>";
    }];
  };
}
