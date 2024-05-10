{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      keymaps = {
        silent = true;
        lspBuf = {
          "<leader>gd" = "definition";
          "K" = "hover";
          "<leader>vws" = "workspace_symbol";
          "<leader>vca" = "code_action";
          "<leader>vrr" = "references";
          "<leader>vrn" = "rename";
        };
        diagnostic = {
          "<leader>vd" = "open_float";
          "[d" = "goto_next";
          "]d" = "goto_prev";
        };
        extra = [
        ];
      };
    };
  };
}
