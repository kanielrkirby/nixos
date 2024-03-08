{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      defaultFileExplorer = true;
      viewOptions.showHidden = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>pv";
        action = "<cmd>Oil<CR>";
      }
    ];
  };
}
