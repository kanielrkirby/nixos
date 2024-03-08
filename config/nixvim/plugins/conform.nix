{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        lua = true;
        action = ''require("conform").format()'';
      }
    ];
  };
}
