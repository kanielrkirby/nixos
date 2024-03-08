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
        action = "require('harpoon-ui').nav_file(1)";
      }
      {
        mode = "n";
        key = "<C-t>";
        action = "require('harpoon-ui').nav_file(2)";
      }
      {
        mode = "n";
        key = "<C-n>";
        action = "require('harpoon-ui').nav_file(3)";
      }
      {
        mode = "n";
        key = "<C-s>";
        action = "require('harpoon-ui').nav_file(4)";
      }
    ];
  };
}
