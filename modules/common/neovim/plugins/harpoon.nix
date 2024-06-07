{
  programs.nixvim = {
    plugins.harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>a";
          toggleQuickMenu = "<leader>e";
        };
    };

    keymaps = [
      {
        mode = "n";
        key = "<C-h>";
        action = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>";
      }
      {
        mode = "n";
        key = "<C-t>";
        action = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>";
      }
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>";
      }
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>lua require('harpoon.ui').nav_file(4)<CR>";
      }
    ];
  };
}
