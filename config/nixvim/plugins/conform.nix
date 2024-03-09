{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = ''<cmd>require("conform").format()<CR>'';
      }
    ];
  };
}
