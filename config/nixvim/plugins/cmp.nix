{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mappingPresets = [ "insert" ];
          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-l>" =
              "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })";
          };
          snippet.expand = "luasnip";
          sources =
            [ { name = "nvim_lsp"; } { name = "luasnip"; } { name = "path"; } ];
        };
      };
      luasnip.enable = true;
    };
  };
}
