{
  programs.nixvim = {
    plugins = {
      luasnip.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mappingPresets = ["insert"];
          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-l>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })";
          };
          snippet.expand = ''
            function(args)
              require("luasnip").lsp_expand(args.body)
            end
          '';
          sources = [{name = "nvim_lsp";} {name = "luasnip";} {name = "path";} {name = "buffer";}];
        };
      };
    };
  };
}
